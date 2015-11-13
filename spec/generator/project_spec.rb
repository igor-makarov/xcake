require 'spec_helper'

module Xcake
  module Generator
    describe Project do

      it 'generates the correct output filepath' do
        cakefile = double()
        allow(cakefile).to receive(:project_name) { 'Project' }

        generator = Project.new
        output_filepath = generator.output_filepath_for_cakefile(cakefile)

        expect(output_filepath).to eq("./Project.xcodeproj")
      end

      it 'generates the project' do
        cakefile = double()
        allow(cakefile).to receive(:project_name) { 'Project' }

        generator = Project.new
        generator.visit_cakefile(cakefile)

        expect(generator.project).not_to be_nil
      end

      #Test Node

      #Test Build Configuration

      #Test Build Configuration

      #Test Schemes

      #Test Writing Out

      #Test Visits
    end
  end
end
