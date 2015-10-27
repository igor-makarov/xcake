require 'xcodeproj'

module Xcake
  module Generator
    class NodeInstaller

      attr_accessor :main_group

      def initialize(group)
        self.main_group = group
      end

      def install(node)
        if node.type == Node::Type::DIRECTORY
          main_group.find_subpath(node.path, true)
        else
          group = main_group.find_subpath(node.parent.path, true)
          file = group.new_reference(node.path)

          node.targets.each do |t|
            t.resources_build_phase.add_file_reference(file)
          end
        end
      end
    end
  end
end
