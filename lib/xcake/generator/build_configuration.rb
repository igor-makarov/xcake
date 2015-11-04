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

          project.build_configuration_list.build_configurations << build_configuration
        end
      end
    end
  end
end
