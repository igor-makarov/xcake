require 'spec_helper'

module Xcake
  describe BuildConfigurable do

    before :each do
      @build_configurable = Object.new
      @build_configurable.extend(BuildConfigurable)

      allow(@build_configurable).to receive(:default_debug_settings).and_return({})
      allow(@build_configurable).to receive(:default_release_settings).and_return({})
    end

    context "when creating debug configuration" do

      before :each do
        @build_configuration = @build_configurable.debug_build_configuration :debug
      end

      it "should store build configuration" do
        expect(@build_configurable.debug_build_configurations.count).to eq(1)
      end

      context "that already exists" do

        before :each do
          @duplicate_build_configuration = @build_configurable.debug_build_configuration :debug
        end

        it "should return same build configuration" do
          expect(@duplicate_build_configuration).to be(@build_configuration)
        end
      end
    end

    context "when creating release configuration" do

      before :each do
        @build_configuration = @build_configurable.release_build_configuration :release
      end

      it "should store build configuration" do
        expect(@build_configurable.release_build_configurations.count).to eq(1)
      end

      context "that already exists" do

        before :each do
          @duplicate_build_configuration = @build_configurable.release_build_configuration :release
        end

        it "should return same build configuration" do
          expect(@duplicate_build_configuration).to be(@build_configuration)
        end
      end
    end

    context "when accessing all configurations" do
      it "should return configuration" do
        expect(@build_configurable.all_build_configurations).not_to be(nil)
      end

      it "should be same configuration" do

        build_configuration = @build_configurable.all_build_configurations

        expect(@build_configurable.all_build_configurations).to be(build_configuration)
      end
    end

    #   debug_build_configurations.each do |b|
    #     b.settings = default_debug_settings.merge!(all_settings).merge!(b.settings)
    #     flattened_build_configurations << b
    #   end
    #
    #   release_build_configurations.each do |b|
    #     b.settings = default_release_settings.merge!(all_settings).merge!(b.settings)
    #     flattened_build_configurations << b
    #   end

    context "when flattening configurations" do

      context "for debug" do

        it "should merge in default settings" do

        end

        it "should merge in all settings" do

        end

        it "should merge in configuration settings" do

        end
      end

      context "for release" do
        it "should merge in default settings" do

        end

        it "should merge in all settings" do

        end

        it "should merge in configuration settings" do

        end
      end

      it "should have same combined number of configurations" do
        @build_configurable.debug_build_configuration :debug
        @build_configurable.debug_build_configuration :release

        flattened_configurations = @build_configurable.flatten_build_configurations
        expect(flattened_configurations.count).to be(2)
      end
    end
  end
end
