module Xcake
  module Generator
    # This build phase generator detects
    # files and adds them to the copy resources phase.
    #
    class IgnorePhase < BuildPhase
      def self.can_install_node(node)
        !File.directory?(node.path) &&
          [".xcconfig", ".plist"].include?(File.extname(node.path))
      end

      def adding_node(node)
      end

      def add_file_reference_to_target(file_reference, target)
      end
    end
  end
end
