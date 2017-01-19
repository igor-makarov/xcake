module Xcake
  # This generator generates the build phases for each target
  # in the project
  #
  class TargetBuildPhaseGenerator < Generator
    def self.dependencies
      [TargetGenerator, TargetDependencyGenerator, TargetFileReferenceGenerator]
    end

    def visit_target(target)
      EventHooks.run_hook :before_adding_build_phases, target

      native_target = @context.native_object_for(target)

      target.pinned_build_phases.each do |phase|
        EventHooks.run_hook :before_adding_custom_build_phase, phase, target

        native_build_phase = @context.native_object_for(phase)
        phase.configure_native_build_phase(native_build_phase, @context)
        native_target.build_phases.unshift(native_build_phase)
      end

      target.build_phases.each do |phase|
        EventHooks.run_hook :before_adding_custom_build_phase, phase, target

        native_build_phase = @context.native_object_for(phase)
        phase.configure_native_build_phase(native_build_phase, @context)
        native_target.build_phases << native_build_phase
      end

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
