# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 's3git/version'

Gem::Specification.new do |spec|
  spec.name          = "s3git"
  spec.version       = S3git::VERSION
  spec.authors       = ["Frank Wessels"]
  spec.email         = ["fwessels@xs4all.nl"]

  spec.summary       = %q{}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/s3git/s3git-rb"
  spec.license       = "Apache 2.0 License"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.extensions = %w[ext/extconf.rb]

  spec.add_dependency "ffi"
  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
