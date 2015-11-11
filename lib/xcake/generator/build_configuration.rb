require 'xcodeproj'

module Xcake
  module Generator
    class BuildConfiguration

      include Visitor

      def initialize(project, build_configuration_target)
        @project = project
        @build_configuration_target = build_configuration_target
      end

      def visit_buildconfiguration(configuration)
        generator = BuildConfiguration.new(project, target)
        generator.visit(configuration)
      end

      def leave_buildconfiguration(configuration)

        puts "Creating build configuration #{configuration.name} for #{project}..."

        build_configuration = @project.new(Xcodeproj::Project::Object::XCBuildConfiguration)

        build_configuration.name = configuration.name
        build_configuration.build_settings = default_debug_settings.merge!(all_settings).merge!(configuration.settings)

        @build_configuration_target.build_configurations << build_configuration
      end
    end
  end
end
