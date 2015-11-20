module Xcake
  module Generator
    class BuildPhase

      include Visitor

      attr_accessor :project

      def self.can_install_node(node)
        true
      end

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

        group = group_for_node(node)
        file_reference = group.new_reference(node.path)

        node.targets.each do |t|
           puts "Added to #{t}"
           add_file_reference_to_target(file_reference, t)
        end
      end

      def leave_node(node)
      end

      def add_file_reference_to_target(file_reference, target)
      end

    end
  end
end
