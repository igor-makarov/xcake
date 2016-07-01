require "spec_helper"

# TODO: BDD plugins_location for Generator and File Reference Installer

class TestPlugin
  include Xcake::Plugin

  def self.plugins_location
    "#{File.dirname(__FILE__)}/fixtures/plugin/*.rb"
  end
end

module Xcake
  describe Plugin do
    it "load all plugins" do
      expect(TestPlugin.load_plugins).to eq([
          PluginFixture
        ])
    end
  end
end
