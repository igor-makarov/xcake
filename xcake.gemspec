# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xcake/version'

Gem::Specification.new do |spec|
  spec.name          = "xcake"
  spec.version       = Xcake::VERSION
  spec.authors       = ["James Campbell"]
  spec.email         = ["james@supmenow.com"]

  spec.summary       = %q{Xcake make managing your xcode project as easy as cake.}
  spec.description   = %q{Xcake is a tool which allows you describe your project in
  an easy to read and mergable format, which you can use to generate a project.
  If your project gets corrupted xcake has your back.}
  spec.homepage      = "http://www.supmenow.com/xcake"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   =  %w{ xcake }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.0.0'
  spec.rubygems_version = "1.6.2"
  spec.required_rubygems_version = Gem::Requirement.new(">= 0") if spec.respond_to? :required_rubygems_version=
  spec.required_ruby_version = '>= 2.0.0'
  spec.specification_version = 3 if spec.respond_to? :specification_version

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "yard"
  spec.add_dependency "claide"
  spec.add_dependency "xcodeproj", "~> 0.28"
end
