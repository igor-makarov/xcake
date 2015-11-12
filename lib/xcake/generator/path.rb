module Xcake
  module Generator
    class Path

      include Visitor

      def initialize(project)
        @project = project
      end

      def group_for_node(node)
        if node.parent.path
          @project.main_group.find_subpath(node.parent.path, true)
        else
          @project.main_group
        end
      end

      def visit_node(node)

        group = group_for_node(n)
        file_reference = group.new_reference(node.path)

        installer = BuildPhase::Registry.generator_for_file_reference(file_reference)

        node.targets.each do |t|

          puts "Adding #{n.path} to #{t}..."

          installer.visit_target(t)
        end
      end

      def leave_node(node)
      end
    end
  end
end
