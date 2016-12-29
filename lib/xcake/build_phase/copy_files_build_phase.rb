module Xcake
  # This class is used to hold a copy files build phase name
  # and script contents
  #
  class CopyFilesBuildPhase < BuildPhase
    attr_accessor :files

    def generate_native_build_phase(target)
      phase = target.new_copy_files_build_phase(name)
    end
  end
end
