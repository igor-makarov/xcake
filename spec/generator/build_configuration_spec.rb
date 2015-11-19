require 'spec_helper'

module Xcake
  module Generator
    describe BuildConfiguration do

      it "should create a new XCBuildConfiguration" do

        project = double()
        expect(project).to receive(:new).with(Xcodeproj::Project::Object::XCBuildConfiguration)

        build_configuration_target = double()
        build_configuration = double()

        generator = BuildConfiguration.new(project, build_configuration_target)
        generator.visit_buildconfiguration(build_configuration)
      end

      #test sets name

      #test sets build settings

      #test add build configurations.



      # build_configuration.name = configuration.name
      # build_configuration.build_settings = configuration.settings
      #
      # @build_configuration_target.build_configurations << build_configuration

    end
  end
end
