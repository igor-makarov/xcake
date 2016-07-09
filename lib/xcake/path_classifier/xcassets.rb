module Xcake
  # This build phase generator detects XCAsset bundles
  #
  class XCAssetsPathClassifier < ResourcePathClassifier
    def self.dependencies
      []
    end

    def self.can_install_node(node)
      File.directory?(node.path) &&
        ['.xcassets'].include?(File.extname(node.path))
    end

    def self.ignore_child_paths
      true
    end
  end
end
