require 'xcodeproj'

module Xcake
  class Cakefile

    include BuildConfigurable

    attr_accessor :project_name
    attr_accessor :targets

    def initialize(name="Project", &block)
      self.project_name = name
      self.targets = []

      block.call(self) if block_given?
    end

    def target(&block)
      target = Target.new(&block)
      self.targets << target

      target
    end

    def application_for(platform, deployment_target, &block)
      application_target = target(&block)

      application_target.type = :application
      application_target.platform = platform
      application_target.deployment_target = deployment_target

      application_target
    end
  end
end
