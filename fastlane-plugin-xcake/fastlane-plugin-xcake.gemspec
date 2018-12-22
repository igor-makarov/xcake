lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/xcake/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-xcake'
  spec.version       = Fastlane::Xcake::VERSION
  spec.authors       = ['James Campbell']
  spec.email         = ['james@supmenow.com']

  spec.summary       = 'DSL for Xcode Projects.'
  spec.description   = 'Create your Xcode projects automatically using a stupid simple DSL.'
  spec.homepage      = 'https://github.com/jcampbell05/xcake/'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']

  spec.add_dependency 'xcake'

  spec.add_development_dependency 'fastlane', '~> 1.89'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rspec', '~> 3.4.0'
end
