require 'spec_helper'

module Xcake
  describe DefaultProjectStructureGenerator do
    before :each do
      @context = double('Context').as_null_object
      @project = double('Project').as_null_object

      @generator = DefaultProjectStructureGenerator.new(@context)
      @generator.visit_project(@project)
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
        @target = double('Target')
       # allow(@target).to receive(:configuration)
      end
      
      it 'should create a scheme with corret name for each configuration' do
        configuration = double('Configuration').as_null_object

      #  allow(@target).to receive(:all_configurations).and_return([configuration])

      #  expect(@target).to receive(:scheme).with('Target-Configuration')
        @generator.visit_target(@target)
      end

      it 'set all actions on scheme to use configuration' do
      end
    end
  end
end
