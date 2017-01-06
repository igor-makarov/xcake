require 'spec_helper'

module Xcake
  describe SchemeGenerator do
    before :each do
      @scheme_list = double('Scheme List')
      @context = double('Context')

      allow(@context).to receive(:scheme_list).and_return(@scheme_list)

      @generator = SchemeGenerator.new(@context)
    end

    it 'should have correct dependencies' do
      expect(SchemeGenerator.dependencies).to eq([TargetGenerator, DefaultProjectStructureGenerator, ConfigurationGenerator])
    end

    it 'should create schemes for each target' do
      target = double('Target')
      native_target = double('Native Target')

      allow(native_target).to receive(:test_target_type?).and_return(false)
      allow(@context).to receive(:native_object_for).and_return(native_target)

      expect(@scheme_list).to receive(:create_schemes_for_target).with(native_target)
      @generator.visit_target(target)
    end

    it 'should skip creating schemes for unit test target' do
      test_target = double('Test Target')
      native_target = double('Native Target')

      allow(native_target).to receive(:test_target_type?).and_return(true)
      allow(@context).to receive(:native_object_for).and_return(native_target)

      expect(@scheme_list).to_not receive(:create_schemes_for_target).with(native_target)
      @generator.visit_target(test_target)
    end
  end
end
