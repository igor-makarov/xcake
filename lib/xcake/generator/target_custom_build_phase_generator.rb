module Xcake
  class TargetCustomBuildPhaseGenerator < Generator

    def self.dependencies
      [TargetGenerator]
    end

    def visit_target(target)

      puts "Generating custom build phases for #{target}..."

      native_target = @context.native_object_for(target)
      target.build_phases.each do |phase|
        puts "Adding phase \"#{phase.name}\""
        phase.generate_native_build_phase(native_target)
      end
    end
  end
end
