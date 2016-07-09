require 'pathname'

module Xcake
  # This class handles classifing the files and how Xcake should handle them.
  #
  #
  class PathClassifier

    EXTENSIONS_MAPPINGS = {
      %w{.a .dylib .so .framework}.freeze => :Library,
      %w{.h .hpp}.freeze => :Header,
      %w{.c .m .mm .cpp .swift}.freeze => :SourceCode,
      %w{.xcassets}.freeze => :Assets,
      %w{.xcdatamodeld}.freeze => :CoreData,
    }.freeze

    def self.extensions
      []
    end

    # @note This should be overidden
    # by subclasses.
    #
    # @param [String] the path
    #
    # @return [Boolean] true if classifier can classify the path.
    #
    # @todo BDD This
    #
    def self.can_classify_path(path)
      components = path.split('/')
      extensions.any? do |ext|
        components.any? do |c|
          ext == File.extname(c)
        end
      end
    end

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
      file_extension = File.extname(path)
      extensions.any? { |ext| ext == file_extension }
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
