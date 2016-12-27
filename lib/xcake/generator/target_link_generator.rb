module Xcake
  class TargetLinkGenerator < Generator
    def self.dependencies
      [TargetGenerator]
    end

    def visit_target(target)
      native_target = @context.native_object_for(target)
      
      target.linked_targets.each do |linked_target|
        target.dependencies << linked_target
      end
    end
  end
end
