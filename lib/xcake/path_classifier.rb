require 'pathname'

module Xcake
  # This class handles classifing the files and how Xcake should handle them.
  #
  class PathClassifier
    EXTENSION_MAPPINGS = {
      PBXFrameworksBuildPhase: %w(.a .dylib .so .framework).freeze,
      PBXHeadersBuildPhase: %w(.h .hpp).freeze,
      PBXSourcesBuildPhase: %w(.c .m .mm .cpp .swift .xcdatamodeld .java .intentdefinition).freeze,
      PBXResourcesBuildPhase: %w(.xcassets).freeze
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
      return false if locale_container?(path)
      return false if inside_classified_container?(path)

      true
    end

    def self.classification_for_path(path)
      classification = EXTENSION_MAPPINGS.detect do |_key, ext_group|
        ext_group.any? { |ext| File.extname(path) == ext }
      end

      return :PBXResourcesBuildPhase if classification.nil?

      classification.first
    end

    def self.should_create_build_phase_for_classification?(classification)
      classification != :PBXHeadersBuildPhase
    end

    class << self
      private

      def locale_container?(path)
        components = path.split('/')
        File.extname(components.last) == '.lproj'
      end

      def inside_classified_container?(path)
        components = path.split('/')

        classified_component_index = components.index do |c|
          classified?(c)
        end

        if !classified_component_index.nil?
          classified_component_index < (components.length - 1)
        else
          false
        end
      end

      def classified?(path)
        EXTENSION_MAPPINGS.values.flatten.any? { |ext| File.extname(path) == ext }
      end
    end
  end
end
