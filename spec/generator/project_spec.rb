require 'spec_helper'

module Xcake
  module Generator
    describe Project do
      it 'stores the cakefile' do
        cakefile = class_double('Cakefile')
        generator = Project.new(cakefile)

        expect(generator.cakefile).to eq(cakefile)
      end

      it 'generates the correct output filepath' do
        cakefile = class_double('Cakefile')
        cakefile.stub(:project_name).and_return('Project')

        generator = Project.new(cakefile)

        expect(generator.output_filepath).to eq("./Project.xcodeproj")
      end

      #Test Generating Project
    end
  end
end
