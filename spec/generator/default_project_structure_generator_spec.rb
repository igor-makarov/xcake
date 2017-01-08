require 'spec_helper'

module Xcake
  describe DefaultProjectStructureGenerator do
    before :each do
      @context = double('Context').as_null_object
      @generator = DefaultProjectStructureGenerator.new(@context)
    end

    context 'when visting project' do
      before :each do
        @project = double('Project').as_null_object
      end

      it 'should store project' do
        @generator.visit_project(@project)
        expect(@generator.project).to be(@project)
      end
    end

    context 'when visting target with no configurations' do
      before :each do
        @target = double('Target').as_null_object

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

        allow(@project).to receive(:all_configurations).and_return([@debug_configuration, @release_configuration])
      end

      it 'should propogate debug configurations' do
        expect(@target).to receive(:configuration).with(@debug_name, @debug_type)
        @generator.visit_target(@target)
      end

      it 'should propogate release configurations' do
        expect(@target).to receive(:configuration).with(@release_name, @release_type)
        @generator.visit_target(@target)
      end
    end

    context 'when visting target with no schemes' do
      
    end
  end
end
