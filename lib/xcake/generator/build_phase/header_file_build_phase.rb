module Xcake
  module Generator
    class HeaderFileBuildPhase < BuildPhase

      def self.can_install_node(node)
        File.directory?(node.path) == false &&
        [".h", ".hpp"].include?(File.extname(node.path)) == true
      end
    end
  end
end
