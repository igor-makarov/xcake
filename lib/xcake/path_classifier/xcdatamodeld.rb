module Xcake
  # This build phase generator detects XCDataModeld bundles
  #
  class XCDataModeldPathClassifier < SourceCodePathClassifier
    def self.dependencies
      []
    end

    def self.can_install_node(node)
      File.directory?(node.path) &&
        ['.xcdatamodeld'].include?(File.extname(node.path))
    end
  end
end
