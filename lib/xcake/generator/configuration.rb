require 'xcodeproj'

module Xcake
  module Generator
    class Configuration

      include Visitor

#TODO: BDD these are stored
      def initialize(project, configuration_target)
        @project = project
        @configuration_target = configuration_target
      end

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
