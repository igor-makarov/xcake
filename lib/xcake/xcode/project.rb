require 'xcodeproj'

module Xcake
  module Xcode
    class Project < Xcodeproj::Project

        def setup_for_xcake
          root_object.remove_referrer(self) if root_object
          root_object = new(Project::Object::PBXProject)
          root_object.add_referrer(self)

          config_list = new(XCConfigurationList)
          root_object.build_configuration_list = config_list

          root_object.main_group = new(PBXGroup)

          @root_object = root_object
        end

        def object_version
          Xcodeproj::Constants::DEFAULT_OBJECT_VERSION.to_s
        end
    end
  end
end
