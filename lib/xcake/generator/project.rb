require 'xcodeproj'

module Xcake
  module Generator
    class Project

      include Visitor

      attr_accessor :context
      attr_accessor :project
      attr_accessor :root_node

      def initialize
        #TODO: Move into Context?
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

        @project.class_prefix = project.class_prefix if project.class_prefix
        @project.organization = project.organization if project.organization

        @context = Context.new
        @context.project = @project
      end

      def leave_project(project)

        generator = Path.new(@context)
        @root_node.accept(generator)

        puts "Creating Dependencies..."
        target_dependency = TargetDependency.new(@context)
        @project.accept(target_dependency)

        puts "Creating Schemes..."
        scheme = Scheme.new(@context)
        @project.accept(scheme)

        puts "Writing Project..."
        @project.save
        project.run_hook :after_save

        puts "Done!"
      end

      def visit_target(target)
        generator = Target.new(@context, @root_node)
        target.accept(generator)
      end

      def leave_target(target)
      end

      def visit_configuration(configuration)
        generator = Configuration.new(@context, @project)
        configuration.accept(generator)
      end

      def leave_configuration(configuration)
      end
    end
  end
end
