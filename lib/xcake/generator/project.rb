require 'xcodeproj'

#TODO: Is this even a true generator ? Maybe move into command ?

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

      #TODO: Use Visitor Pattern for other genetators?

      def build
        project = Xcode::Project.new(output_filepath, true)
        project.setup_for_xcake

        build_xcode_build_configurations(project)
        build_targets(project)

        project.save
      end

      def build_xcode_build_configurations(project)
        generator = BuildConfiguration.new(cakefile, project)
        generator.build
      end

      def build_targets(project)
        generator = Target.new(cakefile, project)
        generator.build
      end
    end
  end
end
