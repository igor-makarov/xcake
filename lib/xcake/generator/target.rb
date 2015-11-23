require 'xcodeproj'

module Xcake
  module Generator
    class Target

      include Visitor

      attr_accessor :project
      attr_accessor :root_node
      attr_accessor :native_target

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
      end

      def leave_target(target)
        @native_target.add_system_frameworks(target.system_frameworks) if target.system_frameworks
      end

      def visit_buildconfiguration(configuration)
        generator = BuildConfiguration.new(@project, @native_target)
        configuration.accept(generator)
      end

      def leave_buildconfiguration(configuration)
        generator = Scheme.new(@project, @native_target)
        configuration.accept(generator)
      end
    end
  end
end
