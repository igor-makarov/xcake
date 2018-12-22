require 'spec_helper'

module Xcake
  describe SchemeGenerator do
    before :each do
      @scheme_list_schemes = []
      @scheme_list = double('Scheme List').as_null_object
      @context = double('Context')
      @scheme = double('Scheme').as_null_object
      @target = double('Target')
      @unit_test_target = double('Unit Test Target')
      @ui_test_target = double('UI Test Target')
      @project = double('Project')

      allow(@target).to receive(:schemes).and_return([@scheme])
      allow(@scheme).to receive(:name).and_return('Scheme')
      allow(@scheme_list).to receive(:schemes).and_return(@scheme_list_schemes)
      allow(@context).to receive(:scheme_list).and_return(@scheme_list)

      @native_target = double('Native Target').as_null_object
      @native_project = double('Native Project').as_null_object
      @native_scheme = double('Native Scheme').as_null_object
      @native_unit_test_target = double('Native Unit Test Target').as_null_object
      @native_ui_test_target = double('Native UI Test Target').as_null_object

      allow(@native_project).to receive(:find_unit_test_target_for_target).and_return(@native_unit_test_target)
      allow(@native_project).to receive(:find_ui_test_target_for_target).and_return(@native_ui_test_target)
      allow(@context).to receive(:native_object_for).with(@target).and_return(@native_target)
      allow(@context).to receive(:native_object_for).with(@project).and_return(@native_project)
      allow(@context).to receive(:native_object_for).with(@scheme).and_return(@native_scheme)
      allow(@context).to receive(:native_object_for).with(@unit_test_target).and_return(@native_unit_test_target)
      allow(@context).to receive(:native_object_for).with(@ui_test_target).and_return(@native_ui_test_target)

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

      it 'should suppress target scheme autocreation' do
        expect(@scheme_list).to receive(:supress_autocreation_of_target).with(@native_target)
        @generator.visit_target(@target)
      end

      context 'when configuring native scheme' do
        it 'should configure with build target' do
          allow(@native_project).to receive(:find_unit_test_target_for_target).and_return(nil)
          allow(@native_project).to receive(:find_ui_test_target_for_target).and_return(nil)

          expect(@native_scheme).to receive(:configure_with_targets).with(@native_target, nil)
          @generator.visit_target(@target)
        end

        it 'should configure with test action' do
          action = double('Build Action')
          allow(@native_scheme).to receive(:test_action).and_return(action)
          expect(action).to receive(:build_configuration=).with(@scheme.test_configuration)
          @generator.visit_target(@target)
        end

        it 'should configure launch action' do
          action = double('Launch Action')
          allow(@native_scheme).to receive(:launch_action).and_return(action)
          expect(action).to receive(:build_configuration=).with(@scheme.launch_configuration)
          @generator.visit_target(@target)
        end

        it 'should configure profile action' do
          action = double('Profile Action')
          allow(@native_scheme).to receive(:profile_action).and_return(action)
          expect(action).to receive(:build_configuration=).with(@scheme.profile_configuration)
          @generator.visit_target(@target)
        end

        it 'should configure analyze action' do
          action = double('Analyze Action')
          allow(@native_scheme).to receive(:analyze_action).and_return(action)
          expect(action).to receive(:build_configuration=).with(@scheme.analyze_configuration)
          @generator.visit_target(@target)
        end

        it 'should configure archive action' do
          action = double('Archive Action')
          allow(@native_scheme).to receive(:archive_action).and_return(action)
          expect(action).to receive(:build_configuration=).with(@scheme.archive_configuration)
          @generator.visit_target(@target)
        end
      end

      it 'should add scheme to scheme list' do
        @generator.visit_target(@target)
        expect(@scheme_list.schemes).to eq([@native_scheme])
      end

      context 'when adding test scheme' do
        it 'should configure with test target' do
          expect(@native_scheme).to receive(:add_test_target).with(@native_unit_test_target)
          expect(@native_scheme).to receive(:add_test_target).with(@native_ui_test_target)
          @generator.visit_target(@target)
        end

        it 'should suppress test target scheme autocreation' do
          expect(@scheme_list).to receive(:supress_autocreation_of_target).with(@native_unit_test_target)
          expect(@scheme_list).to receive(:supress_autocreation_of_target).with(@native_ui_test_target)
          @generator.visit_target(@target)
        end
      end
    end
  end
end
