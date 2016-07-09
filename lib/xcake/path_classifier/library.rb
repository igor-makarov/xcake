module Xcake
  # This build phase generator detects libraries and frameworks
  #
  class LibraryPathClassifier < PathClassifier

    EXTENSIONS = %w(.a .dylib .so .framework).freeze

    def self.can_classify_path(path)
      EXTENSIONS.any? { |ext| path.include?(ext) }
    end
  end
end
