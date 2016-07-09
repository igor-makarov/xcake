require 'pathname'

module Xcake
  # This class handles classifing the files and how Xcake should handle them.
  #
  class PathClassifier

    EXTENSION_MAPPINGS = {
      :LinkLibrary => %w{.a .dylib .so .framework}.freeze,
      :CopyHeaders => %w{.h .hpp}.freeze,
      :CompileSource => %w{.c .m .mm .cpp .swift .xcdatamodeld}.freeze,
      :CopyResources => %w{.xcassets}.freeze,
    }.freeze

    # @note This should be overidden
    # by subclasses.
    #
    # @param [String] the path
    #
    # @return [Boolean] true if classifier thinks the path should be included
    # into the project
    #
    # @todo BDD this
    #
    def self.should_include_path(path)
      return false if is_locale_container(path)
      return false if is_inside_classified_container(path)
      true
    end

    private

    def self.is_locale_container(path)
      components = path.split('/')
      File.extname(components.last) == '.lproj'
    end

    def self.is_inside_classified_container(path)
      components = path.split('/')

      classified_component_index = components.index do |c|
        is_classified(c)
      end

      unless classified_component_index.nil?
        classified_component_index < (components.length - 1)
      else
        false
      end
    end

    def self.is_classified(path)
      EXTENSION_MAPPINGS.values.flatten.any? { |ext| File.extname(path) == ext }
    end
  end
end
