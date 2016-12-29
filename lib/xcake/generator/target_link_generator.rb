module Xcake
  class TargetLinkGenerator < Generator
    def self.dependencies
      [TargetGenerator]
    end

    def visit_target(target)
      return if target.linked_targets.empty?

      #TODO: Remove hook system in 0.8.x - 0.9.x ?
      #TODO: Constant
      native_target = @context.native_object_for(target)
      link_build_phase = target.link_build_phase "Link Linked Targets"
      
      target.linked_targets.each do |linked_target|
        target.target_dependencies << linked_target
        link_build_phase.files << native_target.product_reference.path
      end
    end
  end
end
