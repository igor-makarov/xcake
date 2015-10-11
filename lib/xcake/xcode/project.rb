require 'xcodeproj'

module Xcake
  module Xcode
    class Project < Xcodeproj::Project
        def setup_for_xcake
          root_object.remove_referrer(self) if root_object
          root_object = new(Project::Object::PBXProject)
          root_object.add_referrer(self)

#TODO: Create subclass that manages all of this
          config_list = new(XCConfigurationList)
          root_object.build_configuration_list = config_list

          # config_list.default_configuration_name = 'Release'
          # config_list.default_configuration_is_visible = '0'
          # add_build_configuration('Debug', :debug)
          # add_build_configuration('Release', :release)

          @root_object = root_object
        end

        def object_version
          Xcodeproj::Constants::DEFAULT_OBJECT_VERSION.to_s
        end
    end
  end
end
