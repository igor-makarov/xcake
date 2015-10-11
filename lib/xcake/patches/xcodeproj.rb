require 'xcodeproj'

module Xcodeproj
  Project.class_eval do

    def setup_for_xcake
      root_object.remove_referrer(self) if root_object
      @root_object = new(Project::Object::PBXProject)
      root_object.add_referrer(self)
    end

    def archive_version
      Constants::LAST_KNOWN_ARCHIVE_VERSION.to_s
    end
  end
end
