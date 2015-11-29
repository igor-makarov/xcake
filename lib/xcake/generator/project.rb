require 'xcodeproj'

module Xcake
  module Generator
    class Project

      include Visitor

      attr_accessor :project
      attr_accessor :root_node

      def initialize
        @root_node = Node.new
      end

      def output_filepath_for_project(project)
        "./#{project.project_name}.xcodeproj"
      end

      def visit_project(project)

        puts "Creating Project..."

        output_filepath = output_filepath_for_project(project)

        @project = Xcode::Project.new(output_filepath, true)
        @project.setup_for_xcake
      end

      def leave_project(project)

        generator = Path.new(@project)
        @root_node.accept(generator)

        puts "Writing Project..."
        @project.recreate_user_schemes
        @project.save

        puts "Done!"
      end

      def visit_target(target)
        generator = Target.new(@project, @root_node)
        target.accept(generator)
      end

      def leave_target(target)
      end

      def visit_configuration(configuration)
        generator = Configuration.new(@project, @project)
        configuration.accept(generator)
      end

      def leave_configuration(configuration)
      end
    end
  end
end
