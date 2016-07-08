module Xcake
  class Target
    def parent_configurable
      @project
    end

    # TODO: Move this to a constant, maybe Xcodeproj ones should be brought
    # into here?
    #
    # Perhaps these could be made into a Gem itself?
    def default_settings
      {
        'INFOPLIST_FILE' => "#{name}/Supporting Files/Info.plist"
      }
    end

    def default_debug_settings
      Xcodeproj::Project::ProjectHelper
        .common_build_settings(:debug,
                               platform,
                               deployment_target.to_s,
                               type,
                               language)
        .merge!(default_settings)
        .merge('SWIFT_OPTIMIZATION_LEVEL' => '-Onone')
    end

    def default_release_settings
      Xcodeproj::Project::ProjectHelper
        .common_build_settings(:release,
                               platform,
                               deployment_target.to_s,
                               type,
                               language)
        .merge!(default_settings)
    end
  end
end
