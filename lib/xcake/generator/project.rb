require 'xcodeproj'

#TODO: Is this even a true generator ? Maybe move into command ?

module Xcake
  module Generator
    class Project

      include Visitor

      attr_accessor :cakefile

      def initialize(cakefile)
        self.cakefile = cakefile
      end

      def visit_cakefile(cakefile)

        puts "Reading Cakefile..."
        self.cakefile = cakefile
      end

      def visit_target(target)
        generator = Target.new
        generator.visit(target)
      end

      def output_filepath
        "./#{self.cakefile.project_name}.xcodeproj"
      end

      #TODO: Use Visitor Pattern for other generators?

      def build
        project = Xcode::Project.new(output_filepath, true)
        project.setup_for_xcake

        build_xcode_build_configurations(project)
        build_targets(project)

        project.recreate_user_schemes
        project.save
      end

      def build_xcode_build_configurations(project)
        generator = BuildConfiguration.new(project, cakefile, project)
        generator.build

        build_configuration_list = project.build_configuration_list
        build_configuration_list.default_configuration_name = cakefile.default_build_configuration.to_s if cakefile.default_build_configuration
      end

      def build_targets(project)
        generator = Target.new(cakefile, project)
        generator.build
      end
    end
  end
end
