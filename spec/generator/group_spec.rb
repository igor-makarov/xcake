require 'spec_helper'

module Xcake
  module Generator
    describe Group do
      it 'stores the cakefile' do
        cakefile = Cakefile.new
        project = Project.new(cakefile)

        expect(project.cakefile).to eq(cakefile)
      end
    end
  end
end
