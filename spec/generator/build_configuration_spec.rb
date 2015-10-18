require 'spec_helper'

module Xcake
  module Generator
    describe BuildConfiguration do
      it 'stores the cakefile' do
        cakefile = double()
        generator = BuildConfiguration.new(cakefile, nil)

        expect(generator.cakefile).to eq(cakefile)
      end

      it 'stores the project' do
        project = double()
        generator = BuildConfiguration.new(nil, project)

        expect(generator.project).to eq(project)
      end

        #Test Generating Build Configurations
    end
  end
end
