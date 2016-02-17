require "xcodeproj"

module Xcake
  class Target
    def shell_script_build_phase(name, script)
      phase = ShellScriptBuildPhase.new
      phase.name = name
      phase.script = script.strip_heredoc
      build_phases << phase
      phase
    end
  end
end
