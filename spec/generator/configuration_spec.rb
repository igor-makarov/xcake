require 'spec_helper'

module Xcake
  module Generator
    describe Configuration do

      before :each do
        @xcode_build_configuration = double().as_null_object
        @project = double()

        @build_configuration_target = double().as_null_object
        @build_configuration = double().as_null_object

        @generator = Configuration.new(@project, @build_configuration_target)
      end

      it "should create a new XCBuildConfiguration" do
        expect(@project).to receive(:new).with(Xcodeproj::Project::Object::XCBuildConfiguration).and_return(@xcode_build_configuration)
        @generator.visit_buildconfiguration(@build_configuration)
      end

      context "when configuring XCBuildConfiguration" do

        before :each do
          allow(@project).to receive(:new).and_return(@xcode_build_configuration)
        end

        it "should set name" do
          expect(@xcode_build_configuration).to receive(:name=).with(@build_configuration.name)
          @generator.visit_buildconfiguration(@build_configuration)
        end

        it "should set settings" do
          expect(@xcode_build_configuration).to receive(:build_settings=).with(@build_configuration.settings)
          @generator.visit_buildconfiguration(@build_configuration)
        end

        it 'should store it in it\'s targets build configurations' do
          expect(@build_configuration_target).to receive(:<<).with(@xcode_build_configuration)
          @generator.visit_buildconfiguration(@build_configuration)
        end
    end

    end
  end
end
