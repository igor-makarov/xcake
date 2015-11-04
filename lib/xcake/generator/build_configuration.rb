require 'xcodeproj'

module Xcake
  module Generator
    class BuildConfiguration

      #TODO: Update to make this generic

      attr_accessor :cakefile
      attr_accessor :project
      attr_accessor :build_configurable

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
        build_configuration_list.default_configuration_name = cakefile.default_build_configuration.to_s if cakefile.default_build_configuration
      end
    end
  end
end
