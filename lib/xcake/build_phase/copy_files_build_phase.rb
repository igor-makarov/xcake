module Xcake
  # This class is used to hold a copy files build phase name
  # and script contents
  #
  class CopyFilesBuildPhase < BuildPhase
    attr_accessor :files

    def initialize
      @files = []
      yield(self) if block_given?
    end

    def configure_native_build_phase(native_build_phase)
      phase = target.new_copy_files_build_phase(name)
    end
  end
end
