require "spec_helper"

module Xcake
  describe TargetBuildPhaseGenerator do
    before :each do
      @dsl_target = double("DSL Target")
      @target = double("Target")
      @context = double("Context")
      @generator = TargetBuildPhaseGenerator.new(@context)

      @dsl_dependency = double("DSL Dependency")
      allow(@dsl_target).to receive(:target_dependencies).and_return([@dsl_dependency])

      allow(@context).to receive(:native_object_for).and_return(@target)
    end

    it "should have correct dependencies" do
      expect(TargetBuildPhaseGenerator.dependencies).to eq([TargetGenerator, TargetDependencyGenerator])
    end

    it "should create embed watch app build phase" do

      allow(@dsl_dependency).to receive(:type).and_return(:watch2_app)

      dependency = double("Dependency")
      allow(@context).to receive(:native_object_for).with(@dsl_dependency).and_return(dependency)

      #
      # def create_embed_watchapp_phase(native_target, native_watchapp_target)
      #   phase = native_target.new_copy_files_build_phase("Embed Watch Content")
      #   phase.dst_path = "$(CONTENTS_FOLDER_PATH)/Watch"
      #   phase.symbol_dst_subfolder_spec = :products_directory
      #   phase.add_file_reference(native_watchapp_target.product_reference)
      #   phase
      # end

      @generator.visit_target(@dsl_target)
    end

    it "should create embed watch kit extension build phase" do

      allow(@dsl_dependency).to receive(:type).and_return(:watch2_extension)

      dependency = double("Dependency")
      allow(@context).to receive(:native_object_for).with(@dsl_dependency).and_return(dependency)

      #
      # def create_embed_watchapp_extension_phase(native_target, native_watchapp_extension_target)
      #   phase = native_target.new_copy_files_build_phase("Embed App Extensions")
      #   phase.symbol_dst_subfolder_spec = :plug_ins
      #   phase.add_file_reference(native_watchapp_extension_target.product_reference)
      #   phase
      # end

      @generator.visit_target(@dsl_target)
    end
  end
end
