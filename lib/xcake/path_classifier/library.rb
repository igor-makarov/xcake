module Xcake
  # This build phase generator detects libraries and frameworks
  #
  class LibraryPathClassifier < PathClassifier

    def self.extensions
      %w(.a .dylib .so .framework)
    end
  end
end
