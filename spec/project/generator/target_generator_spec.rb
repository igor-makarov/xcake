require 'spec_helper'

module Xcake
  describe TargetGenerator do
    before :each do
      @context = double('Context')
      @generator = TargetGenerator.new(@context)
    end

    it 'It should create a target' do
      target = double('Target').as_null_object
      expect(@context).to receive(:native_object_for).with(target)
      @generator.visit_target(target)
    end
  end
end
