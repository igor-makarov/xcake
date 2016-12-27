module Xcake
  class TargetLinkGenerator < Generator
    def self.dependencies
      [TargetGenerator]
    end

    def visit_target(target)
      native_target = @context.native_object_for(target)
      
      target.linked_targets.each do |linked_target|
        target.target_dependencies << linked_target
        # - Grab Product of linked_target and attach to 2nd build phase generator
      end
    end
  end
end
