require 'xcodeproj'

module Xcake

  #This class is used to describe the overall
  #Xcode project structure; This forms part of the DSL
  #and is stored in files name `Cakefile`.
  #
  #The Project creates a hiearchy of targets and configurations
  #nessary to generate a xcode project.
  class Project

    include Configurable
    include Visitable

    # @return [String] the name of the project file. This is used as
    #                  the filename.
    #
    attr_accessor :project_name

    # @return [Array<Target>] the list of targets for the project.
    #
    attr_accessor :targets

    # @param    [String] name
    #           the name of the project file. This is used as the filename.
    #
    # @param    [Proc] block
    #           an optional block that configures the project through the DSL.
    #
    # @example  Creating a Project.
    #
    #           Project.new do |c|
    #             c.application_for :ios, 8.0
    #           end
    #
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

    def unit_tests_for(host_target, &block)

      unit_test_target = target do |t|

        t.name = "#{host_target.name}Tests"

        t.type = :unit_test_bundle
        t.platform = host_target.platform
        t.deployment_target = host_target.deployment_target
        t.language = host_target.language

        t.all_build_configurations.settings["TEST_HOST"] = "$(BUILT_PRODUCTS_DIR)/#{host_target.name}.app/#{host_target.name}"
        t.all_build_configurations.settings["BUNDLE_LOADER"] = "$(TEST_HOST)"

        block.call(t) if block_given?
      end

      unit_test_target
    end

    #Configurable

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

    #Visitable

    def accept(visitor)
      visitor.visit(self)

      flatten_configurations.each do |c|
        visitor.visit(c)
        visitor.leave(c)
      end

      self.targets.each do |t|
        visitor.visit(t)
        visitor.leave(t)
      end

      visitor.leave(self)
    end
  end
end
