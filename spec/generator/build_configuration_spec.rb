require 'spec_helper'

module Xcake
  module Generator
    describe BuildConfiguration do

      it "should create a new XCBuildConfiguration" do

        xcode_build_configuration = double().as_null_object
        project = double()
        expect(project).to receive(:new).with(Xcodeproj::Project::Object::XCBuildConfiguration).and_return(xcode_build_configuration)

        build_configuration_target = double().as_null_object
        build_configuration = double().as_null_object

        generator = BuildConfiguration.new(project, build_configuration_target)
        generator.visit_buildconfiguration(build_configuration)
      end

      context "when configuring XCBuildConfiguration" do

        before :each do
          @xcode_build_configuration = double().as_null_object
          @project = double()
          expect(project).to receive(:new).and_return(@xcode_build_configuration)

          @build_configuration_target = double().as_null_object
          @build_configuration = double().as_null_object
        end

        it "should set name" do
          generator = BuildConfiguration.new(@project, @build_configuration_target)
          generator.visit_buildconfiguration(@build_configuration)
        end

        it "should set settings" do
          generator = BuildConfiguration.new(@project, @build_configuration_target)
          generator.visit_buildconfiguration(@build_configuration)
        end
    end

      #test add build configurations.

      # @build_configuration_target.build_configurations << build_configuration

    end
  end
end
