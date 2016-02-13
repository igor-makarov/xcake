require "xcodeproj"

module Xcake
  def self.strip_heredoc(docs)
    indent = docs.scan(/^[ \t]*(?=\S)/).min
    indent_len = (indent || "").length
    docs.gsub(/^[ \t]{#{indent_len}}/, "")
  end

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
