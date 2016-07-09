require 'pathname'

module Xcake
  # This class handles classifing the files and how Xcake should handle them.
  #
  # TODO: Review if we need these as a plugin in the future - maybe this could
  # be a table.
  #
  class PathClassifier
    include Dependency
    include Plugin

    EXTENSIONS_MAPPINGS = {
      %w{a} => :library
    }

    def self.plugins_location
      "#{File.dirname(__FILE__)}/path_classifier/*.rb"
    end

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
