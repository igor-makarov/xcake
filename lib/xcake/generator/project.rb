require 'xcodeproj'

#TODO: Is this even a true generator ? Maybe move into command ?

module Xcake
  module Generator
    class Project

      include Visitor

      def visit_cakefile(cakefile)

        puts "Creating Project..."

        output_filepath = "./#{cakefile.project_name}.xcodeproj"

        @project = Xcode::Project.new(output_filepath, true)
        @project.setup_for_xcake
      end

      def leave_cakefile(cakefile)

        build_configuration_list = @project.build_configuration_list
        build_configuration_list.default_configuration_name = cakefile.default_build_configuration.to_s if cakefile.default_build_configuration

        puts "Writing Project..."

        @project.recreate_user_schemes
        @project.save
      end

      def visit_target(target)
        generator = Target.new(@project)
        target.accept(generator)
      end

      def leave_target(target)
      end

      def visit_buildconfiguration(configuration)
        generator = BuildConfiguration.new(project, project)
        generator.visit(configuration)
      end

      def leave_buildconfiguration(configuration)
      end
    end
  end
end
