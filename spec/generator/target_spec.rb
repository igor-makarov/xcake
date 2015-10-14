require 'spec_helper'

module Xcake
  module Generator
    describe Target do
      it 'stores the cakefile' do
        cakefile = class_double('Cakefile')
        generator = Target.new(cakefile, nil)

        expect(generator.cakefile).to eq(cakefile)
      end

      it 'stores the project' do
        project = class_double('Project')
        generator = Target.new(nil, project)

        expect(generator.project).to eq(project)
      end

      #Test Generating Targets
    end
  end
end
