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

    attr_accessor :all_configurations
    
    public

    attr_accessor :debug_configurations
    attr_accessor :release_configurations
    
    # @return [Array<Configuration>] list of configurations
    #
    def all_configurations
      configurations = []
      
      if debug_configurations.empty?
        configurations << debug_configuration("Debug")
      else
        configurations.concat(debug_configurations)
      end
      
      if release_configurations.empty?
        configurations << release_configuration("Release")
      else
        configurations.concat(release_configurations)
      end
      
      configurations
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
      case method
      when :debug
        configuration_name = debug_configurations
        default_settings = default_debug_settings
      when :release
        configuration_name = release_configurations
        default_settings = default_release_settings
      end
      
      if name.nil?
        build_configuration = configuration_name.first
      else
        build_configuration = configuration_name.detect do |c|
          c.name == name.to_s
        end
      end

      if build_configuration.nil?
        if name.nil?
          name = method.to_s[0].upcase + method.to_s[1..-1]
        end

        build_configuration = Configuration.new(name) do |b|
          b.settings.merge!(default_settings)
          block.call(b) if block_given?
        end
          
        configuration_name << build_configuration
      end

      build_configuration
    end
  end
end
