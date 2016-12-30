require 'spec_helper'

module Xcake
  describe TargetLinkGenerator do
    before :each do
      
      link_build_phase_phase = double('Link Build Phase')
      @link_build_phase_files = []
      allow(link_build_phase).to receive(:files).and_return(@link_build_phase_files)

      @linked_path = "LinkedPath.framework"
      linked_product_reference = double('Linked Product Reference')
      allow(linked_product_reference).to receive(:path).and_return(@linked_path)

      native_target = double('Target').as_null_object
      allow(native_target).to receive(:product_reference).and_return(linked_product_reference)

      @linked_target = double('Linked Target')
      context = double('Context')
      allow(context).to receive(:native_object_for).with(@linked_target).and_return(native_target)

      @target = double('Target')
      @target_dependencies = []
      allow(@target).to receive(:linked_targets).and_return([@linked_target])
      allow(@target).to receive(:link_build_phase).and_return(link_build_phase)
      allow(@target).to receive(:target_dependencies).and_return(@target_dependencies)
      
      @generator = TargetLinkGenerator.new(context)
    end

    it 'should add dependency to linked target' do
      @generator.visit_target(@target)
      expect(@target_dependencies).to eq([@linked_target])
    end

    it 'should add linked target product reference to link library build phase'  do
      @generator.visit_target(@target)
      expect(@link_build_phase_files).to eq([@linked_path])
    end
  end
end
