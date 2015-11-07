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

        default_debug_settings = build_configurable.default_debug_settings
        default_release_settings = build_configurable.default_release_settings
        all_settings = build_configurable.all_build_configurations.settings

        build_configurable.debug_build_configurations.each do |b|
          build_configuration = project.new(Xcodeproj::Project::Object::XCBuildConfiguration)

          build_configuration.name = b.name
          build_configuration.build_settings = default_debug_settings.merge!(all_settings).merge!(b.settings)

          build_configuration_target.build_configurations << build_configuration
        end

        build_configurable.release_build_configurations.each do |b|
          build_configuration = project.new(Xcodeproj::Project::Object::XCBuildConfiguration)

          build_configuration.name = b.name
          build_configuration.build_settings = default_release_settings.merge!(all_settings).merge!(b.settings)

          build_configuration_target.build_configurations << build_configuration
        end
      end
    end
  end
end
