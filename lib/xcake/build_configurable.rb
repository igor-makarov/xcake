module Xcake
  module BuildConfigurable

    attr_accessor :debug_build_configurations
    attr_accessor :release_build_configurations

    def debug_build_configurations
      @build_configurations ||= []
    end

    def release_build_configurations
      @build_configurations ||= []
    end

    def debug_build_configuration(name, &block)
      build_configuration = BuildConfiguration.new(name, &block)
      build_configuration.settings = default_debug_settings
      self.debug_build_configurations << build_configuration
    end

    def release_build_configuration(name, &block)
      build_configuration = BuildConfiguration.new(name, &block)
      build_configuration.settings = default_release_settings
      self.release_build_configurations << build_configuration
    end
  end
end
