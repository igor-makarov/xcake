require 'spec_helper'

module Xcake
  describe TargetLinkGenerator do
    before :each do
      @linked_product_reference = double('Linked Product Reference')
      @frameworks_build_phase = double('Frameworks Build Phase')

      native_target = double('Native Target').as_null_object
      allow(native_target).to receive(:frameworks_build_phase).and_return(@frameworks_build_phase)

      linked_native_target = double('Linked Native Target').as_null_object
      allow(linked_native_target).to receive(:product_reference).and_return(@linked_product_reference)

      @linked_target = double('Linked Target')

      @target = double('Target')
      @target_dependencies = []
      allow(@target).to receive(:linked_targets).and_return([@linked_target])
      allow(@target).to receive(:target_dependencies).and_return(@target_dependencies)

      context = double('Context')
      allow(context).to receive(:native_object_for).with(@target).and_return(native_target)
      allow(context).to receive(:native_object_for).with(@linked_target).and_return(linked_native_target)

      @generator = TargetLinkGenerator.new(context)
    end

    it 'should add dependency to linked target' do
      allow(@frameworks_build_phase).to receive(:add_file_reference)
      @generator.visit_target(@target)
      expect(@target_dependencies).to eq([@linked_target])
    end

    it 'should add linked target product reference to link library build phase'  do
      expect(@frameworks_build_phase).to receive(:add_file_reference).with(@linked_product_reference)
      @generator.visit_target(@target)
    end
  end
end
