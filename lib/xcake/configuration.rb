module Xcake

  # This class repesents configurations
  # in a xcode project. This is an abstraction
  # of Schemes and Build Configurations.
  #
  # This forms part of the DSL and is usally
  # stored in files named `Cakefile`.
  #
  # It holds the build settings and defines
  # how many schemes are created for each
  # target.
  #
  class Configuration

    include Visitable

    # @return [String>] the name of the configuration
    #
    attr_accessor :name

    # the settings for the configuration
    # this is what is used for the build settings
    # for the build configuration.
    #
    # @return [Hash<String, String>] the settings for the configuration
    #
    attr_accessor :settings

    # @param    [String] name
    #           the name of the configuration This is used for the build configuration name.
    #
    # @param    [Proc] block
    #           an optional block that configures the configuration through the DSL.
    #
    # @example  Creating a Configuration.
    #
    #           Configuration.new :debug do |c|
    #             c.settings["INFO_PLIST"] = "./myapp/info.plist"
    #           end
    #
    def initialize(name, &block)
      self.name = name.to_s
      self.settings = {}

      block.call(self) if block_given?
    end
  end
end
