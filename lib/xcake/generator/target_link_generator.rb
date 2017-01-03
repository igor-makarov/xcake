module Xcake
  # This generator handles linking targets
  # specified as being linked in the Cakefile
  #
  class TargetLinkGenerator < Generator
    def self.dependencies
      [TargetGenerator]
    end

    def visit_target(target)
      return if target.linked_targets.empty?

      native_target = @context.native_object_for(target)
      frameworks_build_phase = native_target.frameworks_build_phase

      target.linked_targets.each do |linked_target|
        native_linked_target = @context.native_object_for(linked_target)
        target.target_dependencies << linked_target

        linked_product = native_linked_target.product_reference
        frameworks_build_phase.add_file_reference(linked_product)
      end
    end
  end
end
