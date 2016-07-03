module Xcake
  class TargetGenerator < Generator
    def self.dependencies
      [ProjectMetadataGenerator]
    end

    def visit_target(target)
      EventHooks.run_hook :before_creating_target, target
      @context.native_object_for(target)
    end
  end
end
