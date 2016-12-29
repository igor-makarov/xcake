require 'xcodeproj'

module Xcake
  class Target

    def compile_build_phase(name, script)
      phase = ShellScriptBuildPhase.new
      phase.name = name
      phase.script = script.strip_heredoc
      build_phases << phase
      phase
    end

    def copy_files_build_phase(name, script)
      phase = ShellScriptBuildPhase.new
      phase.name = name
      phase.script = script.strip_heredoc
      build_phases << phase
      phase
    end

    def headers_build_phase(name, script)
      phase = ShellScriptBuildPhase.new
      phase.name = name
      phase.script = script.strip_heredoc
      build_phases << phase
      phase
    end

    def link_build_phase(name, script)
      phase = ShellScriptBuildPhase.new
      phase.name = name
      phase.script = script.strip_heredoc
      build_phases << phase
      phase
    end

    def shell_script_build_phase(name, script)
      phase = ShellScriptBuildPhase.new
      phase.name = name
      phase.script = script.strip_heredoc
      build_phases << phase
      phase
    end
  end
end
