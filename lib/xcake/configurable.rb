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
      @configurations ||= []
    end

    # @param [Array<Configuration>] new list of configurations to set
    #
    def all_configurations=(configurations)
      @configurations = configurations
    end

    # @return [Array<Configuration>] list of configurations of a type
    #
    def configurations_of_type(type)
      all_configurations.select do |c|
        c.type == type
      end
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

    def default_settings_for_type(type)
      case type
      when :debug
        default_debug_settings
      when :release
        default_release_settings
      end
    end

    def build_configuration(type, name, &block)

      default_settings = default_settings_for_type(type)
      configurations = configurations_of_type(type)

      if name.nil?
        build_configuration = configurations.first
      else
        build_configuration = configurations.detect do |c|
          c.name == name.to_s
        end
      end

      if build_configuration.nil?

        name = type.to_s.capitalize if name.nil?

        build_configuration = Configuration.new(name) do |b|

          b.type = type
          b.settings.merge!(default_settings)

          block.call(b) if block_given?
        end

        all_configurations << build_configuration
      end

      build_configuration
    end
  end
end
