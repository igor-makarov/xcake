module Xcake
  class Target
    include Configurable
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

    def include_files
      @include_files ||= "./#{self.name}/**/*.*"
    end

    def system_frameworks
      @system_frameworks ||= default_system_frameworks_for self.platform
    end

    def default_system_frameworks_for(platform)
      (platform == :ios) ? ['Foundation', 'UIKit'] : ['Cocoa']
    end

    #Configurable

    def default_settings
      {
        "INFOPLIST_FILE" => "./$(PRODUCT_NAME)/Supporting Files/Info.plist"
      }
    end

    def default_debug_settings
      Xcodeproj::Project::ProjectHelper.common_build_settings(:debug, platform, deployment_target.to_s, type, language).merge!(default_settings)
    end

    def default_release_settings
      Xcodeproj::Project::ProjectHelper.common_build_settings(:release, platform, deployment_target.to_s, type, language).merge!(default_settings)
    end

    #Visitable

    def accept(visitor)
      visitor.visit(self)

      flatten_configurations.each do |c|
        visitor.visit(c)
        visitor.leave(c)
      end

      visitor.leave(self)
    end
  end
end
