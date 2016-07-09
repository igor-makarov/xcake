module Xcake
  # This build phase generator detects XCAsset bundles
  #
  class XCAssetsPathClassifier < PathClassifier
    def self.dependencies
      []
    end

    def self.extensions
      %w(.xcassets)
    end
  end
end
