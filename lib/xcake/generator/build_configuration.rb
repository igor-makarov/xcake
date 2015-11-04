require 'xcodeproj'

module Xcake
  module Generator
    class BuildConfiguration

      attr_accessor :build_configurable
      attr_accessor :project

      def initialize(build_configurable, project)
        self.build_configurable = build_configurable
        self.project = projectbuild_configurable
      end

      def build
        build_configurable.debug_build_configurations.each do |b|
          build_configuration = project.new(Xcodeproj::Project::Object::XCBuildConfiguration)

          build_configuration.name = b.name
          build_configuration.build_settings = b.settings

          project.build_configurations << build_configuration
        end

        build_configurable.release_build_configurations.each do |b|
          build_configuration = project.new(Xcodeproj::Project::Object::XCBuildConfiguration)

          build_configuration.name = b.name
          build_configuration.build_settings = b.settings

          project.build_configurations << build_configuration
        end
      end
    end
  end
end
