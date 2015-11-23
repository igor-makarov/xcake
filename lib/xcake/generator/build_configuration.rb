require 'xcodeproj'

module Xcake
  module Generator
    class BuildConfiguration

      include Visitor

#TODO: BDD these are stored
      def initialize(project, build_configuration_target)
        @project = project
        @build_configuration_target = build_configuration_target
      end

      def visit_buildconfiguration(configuration)
        puts "Creating build configuration #{configuration.name} for #{@build_configuration_target}..."

        build_configuration = @project.new(Xcodeproj::Project::Object::XCBuildConfiguration)

        build_configuration.name = configuration.name
        build_configuration.build_settings = configuration.settings

        @build_configuration_target.build_configurations << build_configuration
      end

      def leave_buildconfiguration(configuration)
      end
    end
  end
end
