$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require "xcake"

require "coveralls"
Coveralls.wear!

# Load all of our Generators and File Reference Installers
Xcake::Generator.load_plugins
Xcake::FileReferenceInstaller.load_plugins

# Make all of our methods public
RSpec.configure do |config|
  config.before(:each) do
    described_class.send(:public, *described_class.protected_instance_methods)
    described_class.send(:public, *described_class.private_instance_methods)
  end
end
