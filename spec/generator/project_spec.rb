require 'spec_helper'

module Xcake
  module Generator
    describe Project do

      before :each do
        @generator = Project.new

        @cakefile = double().as_null_object
        allow(@cakefile).to receive(:project_name) { 'Project' }
      end

      it 'generates the correct output filepath' do
        output_filepath = @generator.output_filepath_for_cakefile(@cakefile)
        expect(output_filepath).to eq("./Project.xcodeproj")
      end

      it 'generates the project' do
        @generator.visit_cakefile(@cakefile)
        expect(@generator.project).not_to be_nil
      end

      it 'should create root node' do
        expect(@generator.root_node).not_to be_nil
      end

    context 'when finished parsing cakefile' do

      before :each do
        @project = double().as_null_object
        @root_node = double().as_null_object
        @path_generator = double().as_null_object

        @generator.project = @project
        @generator.root_node = @root_node
      end

      it 'run path generator on root node' do
        expect(@root_node).to receive(:accept).with(@path_generator)
        allow(Path).to receive(:new).and_return(@path_generator)

        @generator.leave_cakefile(@cakefile)
      end

      it 'should recreate user schemes' do
        expect(@project).to receive(:recreate_user_schemes)
        @generator.leave_cakefile(@cakefile)
      end

      it 'should save project' do
        expect(@project).to receive(:save)
        @generator.leave_cakefile(@cakefile)
      end
    end


      #Test Writing Out

      #Test Targets

      #Test Build Configuration

      #Test Schemes
    end
  end
end
