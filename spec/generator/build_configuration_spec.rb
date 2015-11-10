require 'spec_helper'

module Xcake
  module Generator
    describe BuildConfiguration do
      it 'stores the project' do
        project = double()
        generator = BuildConfiguration.new(project, nil, nil)

        expect(generator.project).to eq(project)
      end
    end
  end
end
