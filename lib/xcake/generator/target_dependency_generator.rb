module Xcake
  class TargetDependencyGenerator < Generator

    def self.dependencies
      [TargetGenerator]
    end

    def visit_target(target)

      native_target = @context.native_object_for(target)
      native_target.dependencies = target.target_dependencies.map do |dep|
        @context.native_object_for(dep)
      end
    end
  end
end
