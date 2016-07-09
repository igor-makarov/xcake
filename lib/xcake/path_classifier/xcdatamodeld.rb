module Xcake
  # This build phase generator detects XCDataModeld bundles
  # and adds them to the compile source phase.
  #
  class XCDataModeldPathClassifier < SourceCodePathClassifier
    def self.dependencies
      []
    end

    def self.can_install_node(node)
      File.directory?(node.path) &&
        ['.xcdatamodeld'].include?(File.extname(node.path))
    end

    def visit_node(node)
      super

      # Ignore all files inside of the XCDataModel
      node.children = []
    end
  end
end
