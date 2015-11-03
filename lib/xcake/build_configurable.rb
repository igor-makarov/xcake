module Xcake
  module BuildConfigurable
    attr_accessor :build_configurations

    def build_configurations
      @build_configurations || []
    end

    def build_configuration(name)
      self.build_configurations << BuildConfiguration.new(name)
    end
  end
end
