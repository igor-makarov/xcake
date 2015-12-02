module Xcake
  module Generator

    # This build phase generator detects XCAsset bundles
    # and adds them to the copy resources phase.
    #
    class CopyXCAssetsBuildPhase < CopyResourcesBuildPhase

      def self.can_install_node(node)
        File.directory?(node.path) == true &&
        [".xcassets"].include?(File.extname(node.path)) == true
      end

      def visit_node(node)
        super

        #Ignore all files inside of the XCAssets
        node.children = []
      end
    end
  end
end
