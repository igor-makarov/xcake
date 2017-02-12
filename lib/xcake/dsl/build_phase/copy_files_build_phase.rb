module Xcake
  # This class is used to represent a copy files build phase
  #
  class CopyFilesBuildPhase < BuildPhase
    # The name of the build phase as shown in Xcode
    attr_accessor :name

    def build_phase_type
      Xcodeproj::Project::Object::PBXCopyFilesBuildPhase
    end

    def configure_native_build_phase(native_build_phase, _context)
      native_build_phase.name = name
    end

    def to_s
      "BuildPhase<#{name}>"
    end
  end
end
