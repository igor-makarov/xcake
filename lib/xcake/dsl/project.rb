require 'xcodeproj'

module Xcake
  # This class is used to describe the overall
  # Xcode project structure; This forms part of the DSL
  # and is usally stored in files named `Cakefile`.
  #
  # The Project creates a hiearchy of targets and configurations
  # necessary to generate a xcode project.
  class Project
    include Configurable
    include Visitable

    # @!group Configuring a project

    # @return [String] the name of the project file. This is used as
    #                  the filename.
    #
    attr_accessor :name

    # @return [String] the prefix used for Objective-C Classes. This is
    #                  used by xcode when creating new files.
    attr_accessor :class_prefix

    # @return [String] the name of your organization. This is used by xcode when
    #                  creating new files.
    #
    attr_accessor :organization

    # @return [Array<Target>] the list of targets for the project.
    #
    attr_accessor :targets

    # @!group Creating a project

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
    def initialize(name = 'Project')
      @name = name
      @targets = []

      yield(self) if block_given?
    end

    # @!group Working with a project

    # Defines a new target.
    #
    # @param  [Proc] block
    #         an optional block that configures the target through the DSL.
    #
    # @return [Target] the target
    #         the newly created target
    #
    def target(&block)
      target = Target.new(self, &block)
      targets << target
      target
    end

    # @!group Conversion

    def to_s
      "Project<#{name}>"
    end

    # @!group Visitable

    def accept(visitor)
      visitor.visit(self)

      targets.each do |t|
        visitor.visit(t)
        visitor.leave(t)
      end

      visitor.leave(self)
    end

    protected

    # @!group Configurable

    def default_settings
      common_settings = Xcodeproj::Constants::PROJECT_DEFAULT_BUILD_SETTINGS
      Xcodeproj::Project::ProjectHelper.deep_dup(common_settings[:all])
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
