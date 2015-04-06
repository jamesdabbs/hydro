module Hydro
  class Precipitator
    def initialize
      path = "/etc/hydro/config.yml"
      raise "Could not find config file at #{path}" unless File.exists? path
      conf = YAML.load_file path

      @logger = Logger.new conf.fetch "log"

      s3 = conf.fetch "s3"
      @client = Aws::S3::Client.new(
        region: 'us-east-1',
        credentials: Aws::Credentials.new(s3.fetch("id"), s3.fetch("key"))
      )
      @bucket = Aws::S3::Bucket.new client: @client, name: s3.fetch("bucket")

      @rules = conf.fetch("rules").map do |rule|
        Rule.new to: rule.fetch("to"), ext: rule.fetch("ext")
      end
    end

    def upload_file path
      raise "Can't upload `#{path}`: file not found" unless File.exists? path
      @logger.info "Uploading #{path} => #{@bucket.name}"
      object = @bucket.object(File.basename path)
      object.put body: File.open(path)
    end

    def download_file object, path
      @logger.info "Downloading #{object.key} => #{path}"
      File.open path, "w" do |f|
        object.get { |chunk| f.write chunk }
      end
      object.delete
    end

    def download_by_rules
      @bucket.objects.each do |object|
        if rule = @rules.find { |r| r.matches? object }
          download_file object, rule.location_for(object)
        end
      end
    end

    def poll frequency
      @logger.info "Checking for new uploads every #{frequency} seconds"

      at_exit do
        @logger.info "Halting checks"
      end

      loop do
        download_by_rules
        sleep frequency
      end
    end
  end
end
