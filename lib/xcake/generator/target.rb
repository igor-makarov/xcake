require 'xcodeproj'

module Xcake
  module Generator
    class Target

      include Visitor

      attr_accessor :project
      attr_accessor :root_node

      def initialize(project, root_node)
        @project = project
        @root_node = root_node
      end

      def visit_target(target)

        puts "Creating target #{target.name}..."

        @native_target = @project.new_target(target)

        Dir.glob(target.include_files).each do |file|
          @root_node.create_children_with_path(file, @native_target)
        end if target.include_files

        Dir.glob(target.exclude_files).each do |file|
          @root_node.remove_children_with_path(file, @native_target)
        end if target.exclude_files

        #System Framework
      end

      def leave_target(target)
      end

      def visit_buildconfiguration(configuration)
        generator = BuildConfiguration.new(@project, @native_target)
        configuration.accept(generator)
      end

      def leave_buildconfiguration(configuration)
      end
    end
  end
end
