require 'pathname'

module Xcake
  # This class handles classifing the files and how Xcake should handle them.
  #
  class PathClassifier
    include Dependency
    include Plugin

    def self.plugins_location
      "#{File.dirname(__FILE__)}/path_classifier/*.rb"
    end

    def self.reduce_to_classifiable_paths(paths)
      paths
    end

    # @note This should be overidden
    # by subclasses.
    #
    # @param [String] the path
    #
    # @return [Boolean] true if classifier can classify the path.
    #
    def self.can_classify_path(_path)
      true
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

    # @note This should be overidden
    # by subclasses.
    #
    # @return [Boolean] true if sub-paths should be ignored by Xcake
    #
    def self.ignore_child_paths
      false
    end
  end
end
