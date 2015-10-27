require 'xcodeproj'

module Xcake
  module Generator
    class NodeInstaller

      attr_accessor :main_group

      def initialize(group)
        self.main_group = group
      end

      def group_for_node(node)
        if node.parent.path
          main_group.find_subpath(node.parent.path, true)
        else
          main_group
        end
      end

      def install(node)
        if node.type_tree.include?(Node::Type::DIRECTORY) == false
          group = group_for_node(node)
          puts group.class
          file = group.new_reference(node.path)

          node.targets.each do |t|
            t.resources_build_phase.add_file_reference(file)
          end
        end
      end
    end
  end
end
