require 'xcodeproj'

module Xcake
  module Generator

    # This generator processes the configuraions
    # and creates xcode build configurations.
    #
    class Configuration

      include Visitor

#TODO: BDD these are stored

      # @param    [Project] project for the configuration
      #
      # @param    [Object] object in the xcode project configuration is for
      #
      def initialize(project, configuration_target)
        @project = project
        @configuration_target = configuration_target
      end

      protected

      def visit_configuration(configuration)
        puts "Creating build configuration #{configuration.name} for #{@configuration_target}..."

        build_configuration = @project.new(Xcodeproj::Project::Object::XCBuildConfiguration)

        build_configuration.name = configuration.name
        build_configuration.build_settings = configuration.settings

        @configuration_target.build_configurations << build_configuration
      end

      def leave_configuration(configuration)
      end
    end
  end
end
