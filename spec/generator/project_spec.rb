require 'spec_helper'

module Xcake
  module Generator
    describe Project do
      it 'stores the cakefile' do
        cakefile = Cakefile.new
        generator = Project.new(cakefile)

        expect(generator.cakefile).to eq(cakefile)
      end

      it 'generates the correct output filepath' do
        cakefile = Cakefile.new
        generator = Project.new(cakefile)

        expect(generator.output_filepath).to eq("./Project.xcodeproj")
      end
    end
  end
end
