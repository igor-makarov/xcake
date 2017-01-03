module Xcake
  class TargetDependencyGenerator < Generator
    def self.dependencies
      [TargetGenerator, TargetLinkGenerator]
    end

    def visit_target(target)
      native_target = @context.native_object_for(target)
      target.target_dependencies.map do |dep|
        native_dependency = @context.native_object_for(dep)
        native_target.add_dependency(native_dependency)
      end
    end
  end
end
