require 'spec_helper'

module Xcake
  describe XcodeprojContext do
    before :each do
      @context = XcodeprojContext.new
    end

    context 'when creating a project' do
      before :each do
        project_dsl = double('Project')
        allow(project_dsl).to receive(:name).and_return('Name')

        @project = @context.create_object_for_project(project_dsl)
      end

      it 'should set correct path' do
        expect(@project.path.to_s).to eq(File.expand_path('./Name.xcodeproj'))
      end
    end

    context 'when creating a target' do
      before :each do
        @context.project = double('Project')
      end

      it 'should create new target' do
        target_dsl = double('Target')
        expect(@context.project).to receive(:new_target).with(target_dsl)
        @context.create_object_for_target(target_dsl)
      end
    end

    context 'when creating a configuration' do
      before :each do
        @context.project = double('Project')
      end

      it 'should create new configuration' do
        configuration_dsl = double('Configuration')
        expect(@context.project).to receive(:new_configuration).with(configuration_dsl)
        @context.create_object_for_configuration(configuration_dsl)
      end
    end

    context 'when creating a file reference' do
      before :each do
        @context.project = double('Project')
      end

      it 'should create new group' do
        file = double('File Refrence')

        allow(@context.project).to receive(:file_reference_for_path).and_return(file)
        returned_file = @context.file_reference_for_path("path")
        expect(returned_file).to eq(file)
      end
    end

  end
end
