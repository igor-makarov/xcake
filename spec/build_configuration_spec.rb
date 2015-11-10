require 'spec_helper'

module Xcake
  describe BuildConfiguration do

    it "should set the name when created" do
      name = "Configuration"
      configuration = BuildConfiguration.new(name)
      expect(configuration.name).to eq(name)
    end
  end
end
