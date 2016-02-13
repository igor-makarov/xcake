module Xcake

  # TODO: In future this should just infer extra targets and add it to the DSL
  # we should then implement a 2nd pass generator which turns that DSL into
  # build phases
  class TargetBuildPhaseGenerator < Generator

    def self.dependencies
      [TargetGenerator]
    end

    def visit_target(target)
      puts "Generating build phases for #{target}..."

      native_target = @context.native_object_for(target)

    end
  end
end
