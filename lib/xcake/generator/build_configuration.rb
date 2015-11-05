require 'xcodeproj'

module Xcake
  module Generator
    class BuildConfiguration

      attr_accessor :project
      attr_accessor :build_configurable
      attr_accessor :build_configuration_target

      def initialize(project, build_configurable, build_configuration_target)
        self.project = project
        self.build_configurable = build_configurable
        self.build_configuration_target = build_configuration_target
      end

      def build
        build_configurable.debug_build_configurations.each do |b|
          build_configuration = project.new(Xcodeproj::Project::Object::XCBuildConfiguration)

          build_configuration.name = b.name
          build_configuration.build_settings = b.settings

          build_configuration_target.build_configurations << build_configuration
        end

        build_configurable.release_build_configurations.each do |b|
          build_configuration = project.new(Xcodeproj::Project::Object::XCBuildConfiguration)

          build_configuration.name = b.name
          build_configuration.build_settings = b.settings

          build_configuration_target.build_configurations << build_configuration
        end
      end
    end
  end
end
