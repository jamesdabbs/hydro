# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hydro/version'

Gem::Specification.new do |spec|
  spec.name          = "hydro"
  spec.version       = Hydro::VERSION
  spec.authors       = ["James Dabbs"]
  spec.email         = ["jamesdabbs@gmail.com"]
  spec.summary       = %q{Simple utilities for cycling files through the cloud.}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/jamesdabbs/hydro"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency "aws-sdk", "~> 2"
  spec.add_dependency "daemons"
end
