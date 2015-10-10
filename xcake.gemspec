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

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   =  %w{ xcake }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_dependency "claide"
end
