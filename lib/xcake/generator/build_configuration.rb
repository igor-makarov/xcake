require 'xcodeproj'

module Xcake
  module Generator
    class BuildConfiguration

      attr_accessor :cakefile
      attr_accessor :project

      def initialize(cakefile, project)
        self.cakefile = cakefile
        self.project = project
      end

      def build
        cakefile.build_configurations.each do |b|
          build_configuration = project.new(Xcodeproj::Project::Object::XCBuildConfiguration)

          build_configuration.name = b.name
          build_configuration.build_settings = b.settings

          project.build_configurations << build_configuration
        end

        build_configuration_list = project.build_configuration_list
        build_configuration_list.default_configuration_is_visible = '0'
        build_configuration_list.default_configuration_name = project.default_build_configuration.to_s if Project.default_build_configuration
      end
    end
  end
end
