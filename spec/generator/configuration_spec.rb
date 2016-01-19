require 'spec_helper'

module Xcake
  module Generator
    describe Configuration do

      before :each do
        @xcode_build_configuration = double("XCBuildConfiguration").as_null_object
        @context = double("Context")

        @configuration_target = double("Configuration Target").as_null_object
        @configuration = double("Configuration").as_null_object

        @generator = Configuration.new(@context, @configuration_target)
      end

      it "should store the context" do
        expect(@generator.context).to be(@context)
      end

      it "should store the configuration target" do
        expect(@generator.configuration_target).to be(@configuration_target)
      end

      it "should create a new XCBuildConfiguration" do
        expect(@context).to receive(:new_configuration)
        @generator.visit_configuration(@configuration)
      end

      context "when configuring XCBuildConfiguration" do

        before :each do
          allow(@context).to receive(:new_configuration).and_return(@xcode_build_configuration)
        end

        it "should set name" do
          expect(@xcode_build_configuration).to receive(:name=).with(@configuration.name)
          @generator.visit_configuration(@configuration)
        end

        it "should set settings" do
          expect(@xcode_build_configuration).to receive(:build_settings=).with(@configuration.settings)
          @generator.visit_configuration(@configuration)
        end

        it 'should store it in it\'s targets build configurations' do
          expect(@configuration_target).to receive(:<<).with(@xcode_build_configuration)
          @generator.visit_configuration(@configuration)
        end
    end

    end
  end
end
