module Xcake
  # This class is used to hold compile build phase name
  # and script contents
  #
  class CompileBuildPhase < BuildPhase
    attr_accessor :files

    def initialize
      @files = []
      yield(self) if block_given?
    end

    def generate_native_build_phase(target)
      phase = target.new_shell_script_build_phase(name)
      phase.shell_script = script
    end
  end
end
