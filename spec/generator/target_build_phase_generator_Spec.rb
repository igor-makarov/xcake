require "spec_helper"

module Xcake
  describe TargetBuildPhaseGenerator do
    before :each do
      @dsl_target = double("DSL Target")
      @target = double("Target")
      @context = double("Context")
      @generator = TargetBuildPhaseGenerator.new(@context)

      allow(@context).to receive(:native_object_for).and_return(@target)
    end

    it "should have correct dependencies" do
      expect(TargetBuildPhaseGenerator.dependencies).to eq([TargetGenerator, TargetDependencyGenerator])
    end

    # def visit_target(target)
    #   puts "Generating build phases for #{target}..."
    #
    #   native_target = @context.native_object_for(target)
    #
    #   target.target_dependencies.each do |dep|
    #     native_dep = @context.native_object_for(dep)
    #
    #     case dep.type
    #     when :watch2_app
    #       create_embed_watchapp_phase(native_target, native_dep)
    #     when :watch2_extension
    #       create_embed_watchapp_extension_phase(native_target, native_dep)
    #     end
    #   end
    # end
    #
    # def create_embed_watchapp_phase(native_target, native_watchapp_target)
    #   phase = native_target.new_copy_files_build_phase("Embed Watch Content")
    #   phase.dst_path = "$(CONTENTS_FOLDER_PATH)/Watch"
    #   phase.symbol_dst_subfolder_spec = :products_directory
    #   phase.add_file_reference(native_watchapp_target.product_reference)
    #   phase
    # end
    #
    # def create_embed_watchapp_extension_phase(native_target, native_watchapp_extension_target)
    #   phase = native_target.new_copy_files_build_phase("Embed App Extensions")
    #   phase.symbol_dst_subfolder_spec = :plug_ins
    #   phase.add_file_reference(native_watchapp_extension_target.product_reference)
    #   phase
    # end
  end
end
