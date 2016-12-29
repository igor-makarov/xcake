require 'xcodeproj'

#TODO: Document
module Xcake
  class Target

    def compile_build_phase(name, &block)
      phase = CompileBuildPhase.new(&block)
      phase.name = name
      build_phases << phase
      phase
    end

    def copy_files_build_phase(name, &block)
      phase = CopyFilesBuildPhase.new(&block)
      phase.name = name
      build_phases << phase
      phase
    end

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
      build_phases << phase
      phase
    end
  end
end
