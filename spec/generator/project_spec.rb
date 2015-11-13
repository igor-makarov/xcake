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

      #Test Generating Project
    end
  end
end
