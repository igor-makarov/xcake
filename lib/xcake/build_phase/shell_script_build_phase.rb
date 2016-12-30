module Xcake
  # This class is used to represent a shell script build phase
  #
  class ShellScriptBuildPhase < BuildPhase

    # The name of the build phase as shown in Xcode
    attr_accessor :name

    # String coataining the contents of the script to run
    attr_accessor :script

    def build_phase_type
      Xcodeproj::Project::Object::PBXFrameworksBuildPhase
    end

    def configure_native_build_phase(native_build_phase, context)
      native_build_phase.name = name
      native_build_phase.shell_script = script.strip_heredoc
    end
  end
end
