module Xcake
  class Target

    include BuildConfigurable
    include Visitable

    attr_accessor :name
    attr_accessor :type
    attr_accessor :platform
    attr_accessor :deployment_target
    attr_accessor :language
    attr_accessor :include_files
    attr_accessor :exclude_files
    attr_accessor :system_frameworks

    def initialize(&block)
      block.call(self) if block_given?
    end

    def system_frameworks
      @system_frameworks ||= default_system_frameworks_for self.platform
    end

    def default_system_frameworks_for(platform)
      (platform == :ios) ? ['Foundation', 'UIKit'] : ['Cocoa']
    end

    def default_debug_settings
      Xcodeproj::Project::ProjectHelper.common_build_settings(:debug, platform, deployment_target.to_s, type, language)
    end

    def default_release_settings
      Xcodeproj::Project::ProjectHelper.common_build_settings(:release, platform, deployment_target.to_s, type, language)
    end

    #Visitable

    def accept(visitor)
      visitor.visit(self)

      self.debug_build_configurations.each do |c|
        visitor.visit(c)
        visitor.leave(c)
      end

      self.release_build_configurations.each do |c|
        visitor.visit(c)
        visitor.leave(c)
      end

      visitor.leave(self)
    end
  end
end
