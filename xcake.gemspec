# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xcake/version'

Gem::Specification.new do |spec|
  spec.name          = "xcake"
  spec.version       = Xcake::VERSION
  spec.authors       = ["James Campbell"]
  spec.email         = ["james@supmenow.com"]

  spec.summary       = %q{DSL for Xcode Projects.}
  spec.description   = %q{Create your Xcode projects automatically using a stupid simple
  DSL.}
  spec.homepage      = "https://github.com/jcampbell05/xcake/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   =  %w{ xcake }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "yard"
  spec.add_dependency "claide"
  spec.add_dependency "xcodeproj", "~> 0.28"
end
