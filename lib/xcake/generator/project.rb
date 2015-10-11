require 'xcodeproj'

module Xcake
  module Generator
    class Project

      attr_accessor :cakefile

      def initialize(cakefile)
        self.cakefile = cakefile
      end

      def output_filepath
        "./#{self.cakefile.project_name}.xcodeproj"
      end

      def build
        project = Xcode::Project.new(output_filepath, true)
        project.setup_for_xcake

        cakefile.build_configurations.each do |c|
          build_configuration = project.new(XCBuildConfiguration)
          build_configuration.name = c.name
          project.build_configuration_list.build_configurations << build_configuration
        end

        project.save
      end
    end
  end
end
