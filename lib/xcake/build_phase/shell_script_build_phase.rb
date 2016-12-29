module Xcake
  # This class is used to hold a shell script build phase name
  # and script contents
  #
  class ShellScriptBuildPhase < BuildPhase
    attr_accessor :script

    protected

    def configure_native_build_phase(native_build_phase)
      phase = target.new_shell_script_build_phase(name)
      phase.shell_script = script
      phase
    end
  end
end
