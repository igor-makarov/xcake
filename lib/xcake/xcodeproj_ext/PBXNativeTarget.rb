require 'Xcodeproj'

module Xcodeproj
  class Project
    module Object
      class PBXNativeTarget
        def build_phase_by_class(phase_class)
          find_or_create_build_phase_by_class(phase_class)
        end
      end
   end
  end
end
