require 'spec_helper'

module Xcake
  module Generator
    describe Target do
      it 'stores the cakefile' do
        cakefile = Cakefile.new
        generator = Target.new(cakefile)

        expect(generator.cakefile).to eq(cakefile)
      end

      it 'stores the project' do
        generator = Target.new(nil, nil)

        expect(generator.project).to eq(project)
      end
    end
  end
end
