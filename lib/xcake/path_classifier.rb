require 'pathname'

module Xcake
  # This class handles classifing the files and how Xcake should handle them.
  #
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
    # @todo BDD This
    #
    def self.should_include_path(path)
      EXTENSION_MAPPINGS.any? do |ext_group|
        ext_group.any? do |ext|
          path.include?(path) ? (ext == File.extname(path)) : true
        end
      end
    end

    # @note This should be overidden
    # by subclasses.
    #
    # @param [Path] the path
    #
    # @return [String] The classification of the file
    #
    def self.classify_path(_path)
      true
    end
  end
end
