module Xcake
  # This class is used to hold a link libraries build phase name
  # and script contents
  #
  class LinkBuildPhase < BuildPhase
    attr_accessor :libraries

    def generate_native_build_phase(target)
      phase = project.new(PBXFrameworksBuildPhase)
      phase.name = name
      target.build_phases << phase
    end
  end
end
