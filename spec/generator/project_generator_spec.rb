require 'spec_helper'

module Xcake
  describe ProjectGenerator do
    before :each do
      @dsl_project = double('DSL Project').as_null_object

      @project = double('Project').as_null_object

      @context = double('Context')
      allow(@context).to receive(:native_object_for).and_return(@project)

      @generator = ProjectGenerator.new(@context)
    end

    it 'should save the project' do
      expect(@project).to receive(:save)
      @generator.leave_project(@dsl_project)
    end

    it 'should run the before save hook' do
      expect(@dsl_project).to receive(:run_hook).with(:before_save, @project)
      @generator.leave_project(@dsl_project)
    end

    it 'should run the after save hook' do
      expect(@dsl_project).to receive(:run_hook).with(:after_save)
      @generator.leave_project(@dsl_project)
    end
  end
end
