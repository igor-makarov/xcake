require 'spec_helper'

module Xcake
  describe Configurable do

    before :each do
      @configurable = Object.new
      @configurable.extend(Configurable)

      allow(@configurable).to receive(:default_debug_settings).and_return({
        :DEFAULT_SETTING => "DEFAULT_VALUE"
      })

      allow(@configurable).to receive(:default_release_settings).and_return({
        :DEFAULT_SETTING => "DEFAULT_VALUE"
      })
    end

    context "when creating debug configuration" do

      before :each do
        @configuration = @configurable.debug_configuration :debug
      end

      it "should store build configuration" do
        expect(@configurable.debug_configurations.count).to eq(1)
      end

      it "should use that configuration if no name is specified" do
        expect(@configuration.debug_configuration).to eq(@configuration)
      end

      context "that already exists" do

        before :each do
          @duplicate_configuration = @configurable.debug_configuration :debug
        end

        it "should return same build configuration" do
          expect(@duplicate_configuration).to be(@configuration)
        end
      end
    end

    context "when creating release configuration" do

      before :each do
        @configuration = @configurable.release_configuration :release
      end

      it "should store build configuration" do
        expect(@configurable.release_configurations.count).to eq(1)
      end

      it "should use that configuration if no name is specified" do
        expect(@configuration.release_configuration).to eq(@configuration)
      end

      context "that already exists" do

        before :each do
          @duplicate_configuration = @configurable.release_configuration :release
        end

        it "should return same build configuration" do
          expect(@duplicate_configuration).to be(@configuration)
        end
      end
    end

    context "when accessing all configurations" do
      it "should return configuration" do
        expect(@configurable.all_configurations).not_to be(nil)
      end

      it "should be same configuration" do

        configuration = @configurable.all_configurations

        expect(@configurable.all_configurations).to be(configuration)
      end
    end

    context "when flattening configurations" do

      before :each do
        @configurable.all_configurations.settings[:ALL_SETTING] = "ALL_VALUE"
      end

      context "for debug" do

        before :each do
          @configuration = @configurable.debug_configuration(:debug)
          @configuration.settings[:CUSTOM_SETTING] = "CUSTOM_VALUE"
          @configurable.flatten_configurations
        end

        it "should merge in default settings" do
          expect(@configuration.settings[:DEFAULT_SETTING]).to eq("DEFAULT_VALUE")
        end

        it "should merge in all settings" do
          expect(@configuration.settings[:ALL_SETTING]).to eq("ALL_VALUE")
        end

        it "should merge in configuration settings" do
          expect(@configuration.settings[:CUSTOM_SETTING]).to eq("CUSTOM_VALUE")
        end
      end

      context "for release" do

        before :each do
          @configuration = @configurable.debug_configuration(:release)
          @configuration.settings[:CUSTOM_SETTING] = "CUSTOM_VALUE"
          @configurable.flatten_configurations
        end

        it "should merge in default settings" do
          expect(@configuration.settings[:DEFAULT_SETTING]).to eq("DEFAULT_VALUE")
        end

        it "should merge in all settings" do
          expect(@configuration.settings[:ALL_SETTING]).to eq("ALL_VALUE")
        end

        it "should merge in configuration settings" do
          expect(@configuration.settings[:CUSTOM_SETTING]).to eq("CUSTOM_VALUE")
        end
      end

      it "should have same combined number of configurations" do
        @configurable.debug_configuration :debug
        @configurable.debug_configuration :release

        flattened_configurations = @configurable.flatten_configurations
        expect(flattened_configurations.count).to be(2)
      end
    end
  end
end
