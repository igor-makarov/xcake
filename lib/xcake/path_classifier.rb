require 'pathname'

module Xcake
  # This class handles classifing the files and how Xcake should handle them.
  #
  class PathClassifier
    EXTENSION_MAPPINGS = {
      PBXFrameworksBuildPhase: %w{.a .dylib .so .framework}.freeze,
      PBXHeadersBuildPhase: %w{.h .hpp}.freeze,
      PBXSourcesBuildPhase: %w{.c .m .mm .cpp .swift .xcdatamodeld}.freeze,
      PBXCopyFilesBuildPhase: %w{.xcassets}.freeze
    }.freeze

    # @note This should be overidden
    # by subclasses.
    #
    # @param [String] the path
    #
    # @return [Boolean] true if classifier thinks the path should be included
    # into the project
    #
    def self.should_include_path?(path)
      return false if is_locale_container?(path)
      return false if is_inside_classified_container?(path)
      true
    end

    def self.classification_for_class(path)
      classification = EXTENSION_MAPPINGS.detect do |key, hash|
        File.extname(path) == hash[key]
      end

      return :PBXCopyFilesBuildPhase if classification.nil?
      classification.first
    end

    private_class_method

    def self.is_locale_container?(path)
      components = path.split('/')
      File.extname(components.last) == '.lproj'
    end

    def self.is_inside_classified_container?(path)
      components = path.split('/')

      classified_component_index = components.index do |c|
        is_classified?(c)
      end

      unless classified_component_index.nil?
        classified_component_index < (components.length - 1)
      else
        false
      end
    end

    def self.is_classified?(path)
      EXTENSION_MAPPINGS.values.flatten.any? { |ext| File.extname(path) == ext }
    end
  end
end
