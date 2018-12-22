require 'xcodeproj'

module Xcodeproj
  class Project
    module Object
      class PBXNativeTarget
        def build_phase_by_class(phase_class)
          find_or_create_build_phase_by_class(phase_class)
        end

        def library_target_type?
          case symbol_type
          when :framework, :dynamic_library, :static_library
            true
          else
            false
          end
        end
      end
    end
  end
end
