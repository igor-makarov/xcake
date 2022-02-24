lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xcake/version'

Gem::Specification.new do |spec| # rubocop:disable Metrics/BlockLength
  spec.name          = 'xcake'
  spec.version       = Xcake::VERSION
  spec.authors       = ['Igor Makarov', 'James Campbell']
  spec.email         = ['igormaka@gmail.com']

  spec.summary       = 'Generate Xcode Projects'
  spec.description   = 'Cakefile — A Podfile for your main project. 🍰' \
                       'Describe Xcode projects in a human readable format and (re)generate one on demand.'
  spec.homepage      = 'https://github.com/igor-makarov/xcake/'
  spec.license       = 'MIT'

  spec.files         = `git ls-files lib bin -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.executables   = %w(xcake)
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.6'

  spec.add_runtime_dependency 'claide', '< 2.0', '>= 0.9.1'
  spec.add_runtime_dependency 'cork'
  spec.add_runtime_dependency 'deep_merge'
  spec.add_runtime_dependency 'hooks', '~> 0.4.1'
  spec.add_runtime_dependency 'xcodeproj', '< 2.0.0', '>= 1.7.0'

  spec.add_development_dependency 'bundler', '>= 1.10'
  spec.add_development_dependency 'os', '~> 1.0'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'pry-rescue'
  spec.add_development_dependency 'pry-stack_explorer'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rb-readline', '~> 0.5.4'
  spec.add_development_dependency 'rspec', '~> 3.4.0'
  spec.add_development_dependency 'rubocop', '~> 0.64.0'
  spec.add_development_dependency 'rubocop-git', '~> 0.1.1'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'yard', '~> 0.9'
end
