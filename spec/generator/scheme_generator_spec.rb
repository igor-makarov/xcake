require 'spec_helper'

module Xcake
  describe SchemeGenerator do
    before :each do
      @scheme_list = double('Scheme List').as_null_object
      @context = double('Context')
      @scheme = double('Scheme')
      @target = double('Target')
      @project = double('Project')

      allow(@target).to receive(:schemes).and_return([@scheme])
      allow(@scheme).to receive(:name).and_return('Scheme')
      allow(@context).to receive(:scheme_list).and_return(@scheme_list)

      @native_target = double('Native Target').as_null_object
      @native_project = double('Native Project').as_null_object
      @native_scheme = double('Native Scheme').as_null_object

      allow(@context).to receive(:native_object_for).with(@target).and_return(@native_target)
      allow(@context).to receive(:native_object_for).with(@project).and_return(@native_project)
      allow(@context).to receive(:native_object_for).with(@scheme).and_return(@native_scheme)

      @generator = SchemeGenerator.new(@context)
      @generator.visit_project(@project)
    end

    it 'should have correct dependencies' do
      expect(SchemeGenerator.dependencies).to eq([TargetGenerator, DefaultProjectStructureGenerator, ConfigurationGenerator])
    end

    context 'when creating scheme for target' do
      it 'should set name' do
        expect(@native_scheme).to receive(:name=).with(@scheme.name)
        @generator.visit_target(@target)
      end

      it 'should configure with build target' do
        expect(@scheme).to receive(:configure_with_targets).with(@target, nil)
        @generator.visit_target(@target)
      end

      it 'should suppress target scheme autocreation' do
        autocreation_setting = @scheme_list.xcschememanagement['SuppressBuildableAutocreation'][@target.uuid]['primary']
        expect(autocreation_setting).to eq(true)
        @generator.visit_target(@target)
      end

      context 'and adding unit test' do
        before :each do
          @unit_test_target = double('Unit Test Target').as_null_object
          allow(@project).to receive(:find_unit_test_target_for_target).and_return(@unit_test_target)
        end

        it 'should configure with test target' do
          expect(@scheme).to receive(:configure_with_targets).with(@target, @unit_test_target)
          @generator.visit_target(@target)
        end

        it 'add target as depedancy for unit test target' do
          expect(@unit_test_target).to receive(:add_dependency).with(@target)
          @generator.visit_target(@target)
        end

        it 'should suppress unit test target scheme autocreation' do
          autocreation_setting = @scheme_list.xcschememanagement['SuppressBuildableAutocreation'][@unit_test_target.uuid]['primary']
          expect(autocreation_setting).to eq(true)
          @generator.visit_target(@target)
        end
      end
    end
  end
end
