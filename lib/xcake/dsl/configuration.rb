module Xcake
  # This class represents a Build Configuration
  # in a xcode project.
  #
  # This forms part of the DSL and is usally
  # stored in files named `Cakefile`.
  #
  class Configuration
    include Visitable

    # @return [String] the name of the configuration
    #
    attr_accessor :name

    # @return [Symbol] the type of the configuration, either :debug or :release
    #
    attr_accessor :type

    # the settings for the configuration
    # this is what is used for the build settings
    # for the build configuration.
    #
    # @return [Hash<String, String>] the settings for the configuration
    #
    attr_accessor :settings

    # @return [String] the path of the xcconfig file to use for
    #         the build configuration.
    #
    #         This is resolved to a PBXFileReference.
    #
    attr_accessor :configuration_file

    # @param    [String] name
    #           the name of the configuration.
    #           This is used for the build configuration name.
    #
    # @param    [Proc] block
    #           an optional block that configures the
    #           configuration through the DSL.
    #
    # @example  Creating a Configuration.
    #
    #           Configuration.new :debug do |c|
    #             c.settings["INFO_PLIST"] = "./myapp/info.plist"
    #           end
    #
    def initialize(name)
      self.name = name.to_s
      self.settings = {}

      yield(self) if block_given?
    end
  end
end
