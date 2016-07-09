module Xcake
  # This build phase generator detects resource files
  #
  # @note This installer is always the last to be executed.
  #
  class ResourcePathClassifier < PathClassifier
    def self.dependencies
      PathClassifier.descendants.select do |i|
        i != self
      end
    end

    def self.can_classify_path(path)
      true
    end

    def self.should_include_path(path)
      File.extname(path).include?('.lproj') == false
    end
  end
end
