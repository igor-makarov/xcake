module Xcake
  # This build phase generator detects XCDataModeld bundles
  #
  class XCDataModeldPathClassifier < PathClassifier
    def self.dependencies
      []
    end

    def self.extensions
      %w(.xcdatamodeld)
    end
  end
end
