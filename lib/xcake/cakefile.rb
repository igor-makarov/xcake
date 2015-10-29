require 'xcodeproj'

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

    def target(&block)
      target = Target.new(&block)
      self.targets << target

      target
    end

    def application(platform_type, deployment_version, &block)
      application_target = target(&block)
      application_target.type = :application

      application_target
    end
  end
end
