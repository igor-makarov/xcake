module Xcake
  class Cakefile

    attr_accessor :build_configurations
    attr_accessor :project_name
    attr_accessor :targets

    def initialize(name="Project", &block)
      self.build_configurations = []
      self.project_name = name
      self.targets = []

      block.call(self) if block_given?
    end

    def build_configuration(name)
      self.build_configurations << BuildConfiguration.new(name)
    end

    def target(name, type, platform, &block)
      self.targets << Target.new(name, type, platform, &block)
    end
  end
end
