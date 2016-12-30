require 'spec_helper'

module Xcake
  describe TargetFrameworkGenerator do
    before :each do
      @dsl_target = double('DSL Target')
      @target = double('Target')
      @context = double('Context')
      @generator = TargetFrameworkGenerator.new(@context)

      allow(@context).to receive(:native_object_for).and_return(@target)
    end

    it 'should have correct dependencies' do
      expect(TargetFrameworkGenerator.dependencies).to eq([TargetGenerator, ConfigurationGenerator])
    end

    it 'should add system frameworks' do
      frameworks = ['UIKit']

      allow(@dsl_target).to receive(:system_frameworks).and_return(frameworks)
      expect(@target).to receive(:add_system_frameworks).with(frameworks)

      @generator.visit_target(@dsl_target)
    end
  end
end
