module Xcake
  # This class is used to hold a link libraries build phase name
  #
  class LinkBuildPhase < BuildPhase
    attr_accessor :files

    def initialize
      @files = []
      yield(self) if block_given?
    end

    def generate_native_build_phase(target)
      phase = project.new(PBXFrameworksBuildPhase)
      phase.name = name
      target.build_phases << phase
    end
  end
end
