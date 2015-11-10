require 'spec_helper'

module Xcake
  describe BuildConfiguration do

    it "should set the name when created" do
      name = :configuration
      configuration = BuildConfiguration.new(name)
      expect(configuration.name).to eq(name.to_s)
    end
  end
end
