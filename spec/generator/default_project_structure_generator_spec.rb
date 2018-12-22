require 'spec_helper'

module Xcake
  describe DefaultProjectStructureGenerator do
    before :each do
      @context = double('Context').as_null_object
      @project = double('Project').as_null_object

      @generator = DefaultProjectStructureGenerator.new(@context)
      @generator.visit_project(@project)
    end

    it 'should have correct dependencies' do
      expect(DefaultProjectStructureGenerator.dependencies).to eq([ProjectMetadataGenerator, TargetGenerator])
    end

    context 'when visting target with no configurations' do
      before :each do
        @target = double('Target')
        allow(@target).to receive(:all_configurations)

        @debug_name = 'Debug'
        @release_name = 'Release'
        @debug_type = :debug
        @release_type = :release

        @debug_configuration = double('Debug Configuration')
        allow(@debug_configuration).to receive(:name).and_return(@debug_name)
        allow(@debug_configuration).to receive(:type).and_return(@debug_type)

        @release_configuration = double('Debug Configuration')
        allow(@release_configuration).to receive(:name).and_return(@release_name)
        allow(@release_configuration).to receive(:type).and_return(@release_type)
      end

      it 'should propogate debug configurations' do
        allow(@project).to receive(:all_configurations).and_return([@debug_configuration])

        expect(@target).to receive(:configuration).with(@debug_name, @debug_type)
        @generator.visit_target(@target)
      end

      it 'should propogate release configurations' do
        allow(@project).to receive(:all_configurations).and_return([@release_configuration])

        expect(@target).to receive(:configuration).with(@release_name, @release_type)
        @generator.visit_target(@target)
      end
    end

    context 'when visting target with no schemes' do
      before :each do
        target_name = 'Target'
        configuration_name = 'Configuration'

        @configuration = double('Configuration').as_null_object
        allow(@configuration).to receive(:name).and_return(configuration_name)

        @target = double('Target')
        allow(@target).to receive(:name).and_return(target_name)
        allow(@target).to receive(:schemes).and_return([])
        allow(@target).to receive(:configuration)
        allow(@target).to receive(:all_configurations).and_return([@configuration])

        @native_target = double('Native Target')
        allow(@native_target).to receive(:test_target_type?).and_return(false)

        allow(@context).to receive(:native_object_for).and_return(@native_target)
      end

      it 'should create a scheme with corret name for each configuration' do
        expect(@target).to receive(:scheme).with("#{@target.name}-#{@configuration.name}")
        @generator.visit_target(@target)
      end

      context 'when creating scheme' do
        before :each do
          @scheme = double('Scheme').as_null_object
          expect(@target).to receive(:scheme).and_yield(@scheme)
        end

        it 'set test configuration on scheme to use configuration' do
          expect(@scheme).to receive(:test_configuration=).with(@configuration.name)
          @generator.visit_target(@target)
        end

        it 'set launch configuration on scheme to use configuration' do
          expect(@scheme).to receive(:launch_configuration=).with(@configuration.name)
          @generator.visit_target(@target)
        end

        it 'set profile configuration on scheme to use configuration' do
          expect(@scheme).to receive(:profile_configuration=).with(@configuration.name)
          @generator.visit_target(@target)
        end

        it 'set analyze configuration on scheme to use configuration' do
          expect(@scheme).to receive(:analyze_configuration=).with(@configuration.name)
          @generator.visit_target(@target)
        end

        it 'set archive configuration on scheme to use configuration' do
          expect(@scheme).to receive(:archive_configuration=).with(@configuration.name)
          @generator.visit_target(@target)
        end
      end

      it 'should not create implicit schemes for testing targets' do
        allow(@native_target).to receive(:test_target_type?).and_return(true)

        expect(@target).not_to receive(:scheme)
        @generator.visit_target(@target)
      end
    end
  end
end
