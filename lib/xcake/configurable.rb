module Xcake
  # This namespace provides all of methods for
  # the DSL where configurations are specified.
  #
  # Classes for the DSL which want to either
  # specifiy build settings or scheme launch arguments
  # (i.e The Project or Targets) include this namespace.
  #
  # @example
  #   class Application
  #     include Xcake::Configurable
  #   end
  #
  module Configurable

    private

    attr_accessor :all_configuration

    public

    attr_accessor :debug_configurations
    attr_accessor :release_configurations

    # This collects all of the configurations,
    # flattens them and returns them as an array.
    #
    # The process of flattening combines each
    # configuration settings with the defaults
    # and shared "all" settings, in this priority:
    #
    # - default settings
    # - shared settings
    # - configuration settings
    #
    # @return [Array<Configuration>] list of all configurations flattened
    #
    def flatten_configurations
      all_settings = all_configurations.settings
      flattened_configurations = []

      debug_configurations.each do |b|
        b.settings = default_debug_settings.merge!(all_settings).merge!(b.settings)
        flattened_configurations << b
      end

      release_configurations.each do |b|
        b.settings = default_release_settings.merge!(all_settings).merge!(b.settings)
        flattened_configurations << b
      end

      flattened_configurations
    end

    # @return [Array<Configuration>] list of debug configurations
    #
    def debug_configurations
      @debug_configurations ||= []
    end

    # @return [Array<Configuration>] list of release configurations
    #
    def release_configurations
      @release_configurations ||= []
    end

    # This returns the shared "all" configuration
    # use this if you want to set a setting that
    # applies across all configurations.
    #
    # Note: If this setting is set on a configuration
    # already then this won't override it.
    #
    # @example Set a setting across all configurations
    #
    #     t.all_configurations.settings["INFO_PLIST"] = "./myapp/info.plist"
    #
    # @return [Configuration] configuration for the shared settings
    #
    def all_configurations
      @all_configuration ||= Configuration.new(:all)
    end

    # This either finds a release configuration
    # with the same name or creates one.
    #
    # @return [Configuration] the new or existing debug configuration
    #
    def debug_configuration(name = nil, &block)
      build_configuration(:debug, name, &block)
    end

    # This either finds a release configuration
    # with the same name or creates one.
    #
    # @return [Configuration] the new or existing release configuration
    #
    def release_configuration(name = nil, &block)
      build_configuration(:release, name, &block)
    end

    private

    def build_configuration(method, name, &block)
      configuration_name = send("#{method}_configurations")
      if name.nil?
        configuration = configuration_name.first
      else
        configuration = configuration_name.detect do |c|
          c.name == name.to_s
        end
      end

      if configuration.nil?
        configuration = Configuration.new(name) do |b|
          block.call(b) if block_given?
        end

        configuration_name << configuration
      end

      configuration
    end
  end
end
