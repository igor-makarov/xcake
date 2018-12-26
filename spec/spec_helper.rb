require 'simplecov'

require 'pry' unless ENV['CI']

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
                                                                 SimpleCov::Formatter::HTMLFormatter
                                                               ])
SimpleCov.start do
  add_filter %r{^/spec/}
end

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'xcake'

# Load all of our Generators
Xcake::Generator.load_plugins

# Make all of our methods public
RSpec.configure do |config|
  config.before(:each) do
    described_class.send(:public, *described_class.protected_instance_methods)
    described_class.send(:public, *described_class.private_instance_methods)
  end
end
