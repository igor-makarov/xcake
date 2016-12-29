module Xcake
  # This class is used to hold a headers build phase name
  # and script contents
  #
  class HeadersBuildPhase < BuildPhase
    attr_accessor :public
    attr_accessor :private
    attr_accessor :project

    def generate_native_build_phase(target)
      phase = project.new(PBXHeadersBuildPhase)
      phase.name = name
      target.build_phases << phase
    end
  end
end
