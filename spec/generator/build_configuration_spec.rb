require 'spec_helper'

module Xcake
  module Generator
    describe BuildConfiguration do
      it 'stores the cakefile' do
        cakefile = Cakefile.new
        generator = BuildConfiguration.new(cakefile)

        expect(generator.cakefile).to eq(cakefile)
      end

      it 'stores the project' do
        generator = BuildConfiguration.new(nil, nil)

        expect(generator.project).to eq(project)
      end
    end
  end
end
