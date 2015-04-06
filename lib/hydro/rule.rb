module Hydro
  class Rule
    attr_reader :ext, :to

    def initialize opts={}
      @ext = opts.fetch :ext
      @to  = opts.fetch :to
      FileUtils.mkdir_p @to
    end

    def matches? object
      if ext
        object.key.end_with? ext
      else
        true
      end
    end

    def location_for object
      "#{to}/#{object.key}"
    end
  end
end
