# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xcake/version'

Gem::Specification.new do |spec|
  spec.name          = 'xcake'
  spec.version       = Xcake::VERSION
  spec.authors       = ['James Campbell']
  spec.email         = ['james@supmenow.com']

  spec.summary       = 'DSL for Xcode Projects.'
  spec.description   = 'Create your Xcode projects automatically using a stupid simple DSL.'
  spec.homepage      = 'https://github.com/jcampbell05/xcake/'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.executables = %w(xcake)
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.0.0'

  spec.add_dependency 'claide', '< 2.0', '>= 0.9.1'
  spec.add_dependency 'cork'
  spec.add_dependency 'hooks', '~> 0.4.1'
  spec.add_dependency 'xcodeproj', '< 2.0.0', '>= 0.21'

  # Lock `activesupport` (transitive dependency via `xcodeproj`) to keep supporting system ruby
  spec.add_dependency 'activesupport', '< 5'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.4.0'
  spec.add_development_dependency 'coveralls', '~> 0.8'
  spec.add_development_dependency 'rubocop-git', '~> 0.1.1'
  spec.add_development_dependency 'yard', '~> 0.8'
  spec.add_development_dependency 'pry', '~> 0.10'
end
