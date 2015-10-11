require 'xcodeproj'

module Xcake
  module Xcode
    class Project < Xcodeproj::Project
        def setup_for_xcake
          root_object.remove_referrer(self) if root_object
          @root_object = new(Project::Object::PBXProject)
          root_object.add_referrer(self)
        end

        def object_version
          Xcodeproj::Constants::DEFAULT_OBJECT_VERSION.to_s
        end
    end
  end
end
