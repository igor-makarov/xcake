require 'spec_helper'

module Xcake
  describe ProjectMetadataGenerator do
    before :each do
      @dsl_project = double('DSL Project').as_null_object
      allow(@dsl_project).to receive(:class_prefix).and_return('Prefix')
      allow(@dsl_project).to receive(:organization).and_return('Organization')

      @project = double('Project').as_null_object

      @context = double('Context')
      allow(@context).to receive(:native_object_for).and_return(@project)

      @generator = ProjectMetadataGenerator.new(@context)
    end

    it 'should set the class prefix' do
      expect(@project).to receive(:class_prefix=).with(@dsl_project.class_prefix)
      @generator.visit_project(@dsl_project)
    end

    it 'should set the organization' do
      expect(@project).to receive(:organization=).with(@dsl_project.organization)
      @generator.visit_project(@dsl_project)
    end
  end
end
