module Xcake
  # TODO: In future this should just infer extra targets and add it to the DSL
  # we should then implement a 2nd pass generator which turns that DSL into
  # build phases
  class TargetBuildPhaseGenerator < Generator
    def self.dependencies
      [TargetGenerator, TargetDependencyGenerator]
    end

    def visit_target(target)
      EventHooks.run_hook :before_adding_build_phases, target

      native_target = @context.native_object_for(target)

      target.target_dependencies.each do |dep|
        native_dep = @context.native_object_for(dep)

        case dep.type
        when :watch2_app
          create_embed_watchapp_phase(native_target, native_dep)
        when :watch2_extension
          create_embed_watchapp_extension_phase(native_target, native_dep)
        end
      end
    end

    def create_embed_watchapp_phase(native_target, native_watchapp_target)
      EventHooks.run_hook :before_adding_embed_watch_app_phase

      phase = native_target.new_copy_files_build_phase('Embed Watch Content')
      phase.dst_path = '$(CONTENTS_FOLDER_PATH)/Watch'
      phase.symbol_dst_subfolder_spec = :products_directory
      phase.add_file_reference(native_watchapp_target.product_reference, true)
      phase
    end

    def create_embed_watchapp_extension_phase(native_target, native_watchapp_extension_target)
      EventHooks.run_hook :before_adding_embed_watch_extension_phase

      product_reference = native_watchapp_extension_target.product_reference
      phase = native_target.new_copy_files_build_phase('Embed App Extensions')
      phase.symbol_dst_subfolder_spec = :plug_ins
      phase.add_file_reference(product_reference, true)
      phase
    end
  end
end
