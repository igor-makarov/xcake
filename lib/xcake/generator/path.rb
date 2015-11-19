module Xcake
  module Generator
    class Path

      include Visitor

      attr_accessor :project

      def initialize(project)
        @project = project
      end

      def group_for_node(node)
        if node.parent
          @project.main_group.find_subpath(node.parent.path, true)
        else
          @project.main_group
        end
      end

      def visit_node(node)

        puts "Adding #{node.path}..."

        group = group_for_node(node)
        file_reference = group.new_reference(node.path) if File.directory?(node.path)

        installer = BuildPhase::Registry.generator_for_file_reference(file_reference)

        node.targets.each do |t|

          puts "Added to #{t}"
          installer.visit_target(t)
        end
      end

      def leave_node(node)
      end
    end
  end
end
