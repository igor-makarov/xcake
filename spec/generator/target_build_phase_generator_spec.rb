require 'spec_helper'

module Xcake
  describe TargetBuildPhaseGenerator do
    before :each do
      @dsl_target = double('DSL Target')
      @context = double('Context')
      @generator = TargetBuildPhaseGenerator.new(@context)
      @target = double('Target')

      @dsl_dependency = double('DSL Dependency')
      allow(@dsl_target).to receive(:pinned_build_phases).and_return([])
      allow(@dsl_target).to receive(:build_phases).and_return([])
      allow(@dsl_target).to receive(:target_dependencies).and_return([@dsl_dependency])

      allow(@context).to receive(:native_object_for).and_return(@target)
    end

    it 'should have correct dependencies' do
      expect(TargetBuildPhaseGenerator.dependencies).to eq([TargetGenerator,
                                                            TargetDependencyGenerator,
                                                            TargetFileReferenceGenerator])
    end

    it 'should create embed watch app build phase' do
      allow(@dsl_dependency).to receive(:type).and_return(:watch2_app)

      dependency = double('Dependency')
      product_reference = double('Product Reference')
      allow(dependency).to receive(:product_reference).and_return(product_reference)

      phase = double('Phase')

      expect(phase).to receive(:dst_path=).with('$(CONTENTS_FOLDER_PATH)/Watch')
      expect(phase).to receive(:symbol_dst_subfolder_spec=).with(:products_directory)
      expect(phase).to receive(:add_file_reference)
        .with(product_reference, true)

      expect(@target).to receive(:new_copy_files_build_phase).with('Embed Watch Content').and_return(phase)
      allow(@context).to receive(:native_object_for).with(@dsl_dependency).and_return(dependency)

      @generator.visit_target(@dsl_target)
    end

    it 'should create embed watch kit extension build phase' do
      allow(@dsl_dependency).to receive(:type).and_return(:watch2_extension)

      dependency = double('Dependency')
      product_reference = double('Product Reference')
      allow(dependency).to receive(:product_reference).and_return(product_reference)

      phase = double('Phase')

      expect(phase).to receive(:symbol_dst_subfolder_spec=).with(:plug_ins)
      expect(phase).to receive(:add_file_reference)
        .with(product_reference, true)

      expect(@target).to receive(:new_copy_files_build_phase).with('Embed App Extensions').and_return(phase)
      allow(@context).to receive(:native_object_for).with(@dsl_dependency).and_return(dependency)

      @generator.visit_target(@dsl_target)
    end
  end
end
