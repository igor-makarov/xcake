require 'spec_helper'

module Xcake
  describe SchemeGenerator do
    before :each do
      @scheme_list = double('Scheme List').as_null_object
      @context = double('Context')

      allow(@context).to receive(:scheme_list).and_return(@scheme_list)

      @generator = SchemeGenerator.new(@context)
    end

    it 'should have correct dependencies' do
      expect(SchemeGenerator.dependencies).to eq([TargetGenerator, DefaultProjectStructureGenerator, ConfigurationGenerator])
    end

    it 'should create schemes for each target' do
      target = double('Target').as_null_object
      native_target = double('Native Target')

      allow(native_target).to receive(:test_target_type?).and_return(false)
      allow(@context).to receive(:native_object_for).and_return(native_target)

     # expect(@scheme_list).to receive(:create_schemes_for_target).with(native_target)
      @generator.visit_target(target)
    end

    it 'should skip creating schemes for unit test target' do
      test_target = double('Test Target').as_null_object
      native_target = double('Native Target')

      allow(native_target).to receive(:test_target_type?).and_return(true)
      allow(@context).to receive(:native_object_for).and_return(native_target)

      expect(@scheme_list).to_not receive(:create_schemes_for_target).with(native_target)
      @generator.visit_target(test_target)
    end

      #    context 'when creating scheme for target' do
      #   before :each do
      #     @build_configuration = double('Build Configuration').as_null_object
      #     allow(@target).to receive(:build_configurations).and_return([@build_configuration])

      #     @scheme = double('Scheme').as_null_object
      #     allow(Scheme).to receive(:new).and_return(@scheme)
      #   end

      #   it 'should set correct name' do
      #     allow(@build_configuration).to receive(:name).and_return('debug')
      #     expect(@scheme).to receive(:name=).with("#{@target.name}-#{@build_configuration.name}")
      #     @scheme_list.create_schemes_for_target(@target)
      #   end

      #   it 'should configure with build target' do
      #     expect(@scheme).to receive(:configure_with_targets).with(@target, nil)
      #     @scheme_list.create_schemes_for_target(@target)
      #   end

      #   it 'should suppress target scheme autocreation' do
      #     @scheme_list.create_schemes_for_target(@target)
      #     autocreation_setting = @scheme_list.xcschememanagement['SuppressBuildableAutocreation'][@target.uuid]['primary']
      #     expect(autocreation_setting).to eq(true)
      #   end

      #   context 'and adding unit test' do
      #     before :each do
      #       @unit_test_target = double('Unit Test Target').as_null_object
      #       allow(@project).to receive(:find_unit_test_target_for_target).and_return(@unit_test_target)
      #     end

      #     it 'should configure with test target' do
      #       expect(@scheme).to receive(:configure_with_targets).with(@target, @unit_test_target)
      #       @scheme_list.create_schemes_for_target(@target)
      #     end

      #     it 'add target as depedancy for unit test target' do
      #       expect(@unit_test_target).to receive(:add_dependency).with(@target)
      #       @scheme_list.create_schemes_for_target(@target)
      #     end

      #     it 'should suppress unit test target scheme autocreation' do
      #       @scheme_list.create_schemes_for_target(@target)
      #       autocreation_setting = @scheme_list.xcschememanagement['SuppressBuildableAutocreation'][@unit_test_target.uuid]['primary']
      #       expect(autocreation_setting).to eq(true)
      #     end
      #   end
      # end
  end
end
