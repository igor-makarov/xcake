require 'spec_helper'

module Xcake
  module Generator
    describe Group do
      it 'stores the cakefile' do
        cakefile = Cakefile.new
        generator = Group.new(cakefile)

        expect(generator.cakefile).to eq(cakefile)
      end

      it 'stores the project' do
        generator = Group.new(nil, nil)

        expect(generator.project).to eq(project)
      end
    end
  end
end
