require 'spec_helper'

module Xcake
  module Generator
    describe Project do

      before :each do
        @generator = Project.new

        @cakefile = double()
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

      it 'run path generator on root node' do
        @generator.leave_cakefile(@cakefile)
      end

      #Test Writing Out

      #Test Targets

      #Test Build Configuration

      #Test Schemes
    end
  end
end
