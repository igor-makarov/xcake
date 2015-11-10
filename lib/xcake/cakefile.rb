require 'xcodeproj'

module Xcake
  class Cakefile

    include BuildConfigurable

    attr_accessor :default_build_configuration
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

    def application_for(platform, deployment_target, language=:objc, &block)

      application_target = target do |t|
        t.type = :application
        t.platform = platform
        t.deployment_target = deployment_target
        t.language = language

        block.call(t) if block_given?
      end

      application_target
    end

    def default_settings
        common_settings = Xcodeproj::Constants::PROJECT_DEFAULT_BUILD_SETTINGS
        settings = Xcodeproj::Project::ProjectHelper.deep_dup(common_settings[:all])
    end

    def default_debug_settings
      common_settings = Xcodeproj::Constants::PROJECT_DEFAULT_BUILD_SETTINGS
      default_settings.merge!(Xcodeproj::Project::ProjectHelper.deep_dup(common_settings[:debug]))
    end

    def default_release_settings
      common_settings = Xcodeproj::Constants::PROJECT_DEFAULT_BUILD_SETTINGS
      default_settings.merge!(Xcodeproj::Project::ProjectHelper.deep_dup(common_settings[:release]))
    end
  end
end
