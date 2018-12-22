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

    attr_accessor :configurations

    public

    # @return [Array<Configuration>] list of all configurations
    #
    def all_configurations
      if @configurations.nil?
        @configurations = []

        if parent_configurable && parent_configurable.all_configurations
          copy_parent_configurations
        else
          debug_configuration :Debug
          release_configuration :Release
        end

      end

      @configurations
    end

    private

    def copy_parent_configurations
      return unless parent_configurable

      parent_configurable.all_configurations.each do |c|
        configuration(c.name, c.type)
      end
    end

    public

    # @param [Array<Configuration>] new list of configurations to set
    #
    def all_configurations=(configurations)
      @configurations = configurations
    end

    # @return [Array<Configuration>] list of configurations of a type
    #
    def configurations_of_type(type)
      return [] if @configurations.nil?

      @configurations.select do |c|
        c.type == type
      end
    end

    # This either finds a release configuration
    # with the same name or creates one.
    #
    # @deprecated Please use `configuration <name>, :debug`
    #
    # @return [Configuration] the new or existing debug configuration
    #
    def debug_configuration(name = nil, &block)
      configuration(name, :debug, &block)
    end

    # This either finds a release configuration
    # with the same name or creates one.
    #
    # @deprecated Please use `configuration <name>, :release`
    #
    # @return [Configuration] the new or existing release configuration
    #
    def release_configuration(name = nil, &block)
      configuration(name, :release, &block)
    end

    # This either finds a configuration
    # with the same name and type or creates one.
    #
    # @return [Configuration] the new or existing configuration
    #
    def configuration(name, type)
      default_settings = default_settings_for_type(type)
      configurations = configurations_of_type(type)

      build_configuration = if name.nil?
                              configurations.first
                            else
                              configurations.detect do |c|
                                c.name == name.to_s
                              end
                            end

      if build_configuration.nil?

        name = type.to_s.capitalize if name.nil?

        build_configuration = Configuration.new(name) do |b|
          b.type = type
          b.settings.merge!(default_settings)

          yield(b) if block_given?
        end

        @configurations ||= []
        @configurations << build_configuration
      end

      build_configuration
    end

    private

    def parent_configurable
      nil
    end

    def default_settings_for_type(type)
      case type
      when :debug
        default_debug_settings
      when :release
        default_release_settings
      end
    end
  end
end
