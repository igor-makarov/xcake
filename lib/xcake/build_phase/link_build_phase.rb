module Xcake
  # This class is used to hold a shell script build phase name
  # and script contents
  #
  class ShellScriptBuildPhase
    attr_accessor :name
    attr_accessor :script

    def generate_native_build_phase(target)
      phase = target.new_shell_script_build_phase(name)
      phase.shell_script = script
      phase
    end
  end
end
