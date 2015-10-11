require 'xcodeproj'

module Xcodeproj
  Project.class_eval do
    def archive_version
      Constants::LAST_KNOWN_ARCHIVE_VERSION
    end
  end
end
