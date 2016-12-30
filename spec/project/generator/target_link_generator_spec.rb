require 'spec_helper'

module Xcake
  describe TargetLinkGenerator do
    before :each do
      @context = double('Context')
      @generator = TargetLinkGenerator.new(@context)

      @linked_target = double('Linked Target')

      @target = double('Target')
      @target_dependencies = []
      @link_build_phase = double('Link Build Phase').as_null_object

      @native_target = double('Target').as_null_object

      allow(@target).to receive(:linked_targets).and_return([@linked_target])
      allow(@target).to receive(:link_build_phase).and_return(@link_build_phase)
      allow(@target).to receive(:target_dependencies).and_return(@target_dependencies)
      allow(@context).to receive(:native_object_for).and_return(@native_target)
    end

    it 'should add dependency to linked target' do
      @generator.visit_target(@target)
      expect(@target_dependencies).to eq([@linked_target])
    end

    # it 'It should create a target' do
    #   target = double('Target').as_null_object
    #   expect(@context).to receive(:native_object_for).with(target)
    #   @generator.visit_target(target)
    # end

    # def visit_target(target)
    #   return if target.linked_targets.empty?

    #   native_target = @context.native_object_for(target)
    #   link_build_phase = target.link_build_phase
      
    #   target.linked_targets.each do |linked_target|
    #     target.target_dependencies << linked_target
    #     link_build_phase.files << native_target.product_reference.path
    #   end
    # end
  end
end
