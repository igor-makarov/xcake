require 'xcodeproj'

#TODO: Document
module Xcake
  class Target

    def headers_build_phase(name, &block)
      phase = HeadersBuildPhase.new(&block)
      phase.name = name
      build_phases << phase
      phase
    end

    def link_build_phase(name, &block)
      phase = LinkBuildPhase.new(&block)
      phase.name = name
      build_phases << phase
      phase
    end

    def shell_script_build_phase(name, script, &block)
      phase = ShellScriptBuildPhase.new(&block)
      phase.name = name
      phase.script = script
      build_phases << phase
      phase
    end
  end
end
