module Xcake
  class Target
    def parent_configurable
      @project
    end

    def default_settings
      {
        'INFOPLIST_FILE' => "#{name}/Supporting Files/Info.plist",
        'LD_RUNPATH_SEARCH_PATHS'  => ['$(inherited)', '@executable_path/Frameworks', '@loader_path/Frameworks']
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
