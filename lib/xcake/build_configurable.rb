module Xcake
  module BuildConfigurable
    attr_accessor :build_configurations

    def build_configurations
      @build_configurations ||= []
    end

    def build_configuration(name, &block)
      build_configuration = BuildConfiguration.new(name, &block)
      self.build_configurations << build_configuration
    end

    def debug_build_configuration(name, &block)
      build_configuration = BuildConfiguration.new(name, &block)
      self.build_configurations << build_configuration
    end

    def release_build_configuration(name, &block)
      build_configuration = BuildConfiguration.new(name, &block)
      self.build_configurations << build_configuration
    end
  end
end
