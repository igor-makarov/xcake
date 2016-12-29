module Xcake
  # This class is used to describe a build phase for a
  # Xcode project; This forms part of the DSL
  # and is usually stored in files named `Cakefile`.
  #
  class ShellScriptBuildPhase
    attr_accessor :name

    def generate_native_build_phase(target)
      phase = target.new_shell_script_build_phase(name)
      phase.shell_script = script
      phase
    end
  end
end
