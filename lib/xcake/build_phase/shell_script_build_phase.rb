module Xcake
  # This class is used to hold a shell script build phase name
  # and script contents
  #
  class ShellScriptBuildPhase < BuildPhase
    attr_accessor :script

    def build_phase_type
      Xcodeproj::Project::Object::PBXFrameworksBuildPhase
    end

    def configure_native_build_phase(native_build_phase, context)
      super(native_build_phase, context)
      
      native_build_phase.shell_script = script
    end
  end
end
