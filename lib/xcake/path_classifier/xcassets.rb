module Xcake
  # This build phase generator detects XCAsset bundles
  # and adds them to the copy resources phase.
  #
  class XCAssetsPathClassifier < CopyResourcesPathClassifier
    def self.dependencies
      []
    end

    def self.can_install_node(node)
      File.directory?(node.path) &&
        ['.xcassets'].include?(File.extname(node.path))
    end

    def visit_node(node)
      super

      # Ignore all files inside of the XCAssets
      node.children = []
    end
  end
end
