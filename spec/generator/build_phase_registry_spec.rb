require 'spec_helper'

module Xcake
  module Generator
    class BuildPhase
      describe Registry do
        # it 'should return registered generators in correct order' do
        #   expect(Registry.build_phase_generators).to eq([
        #       CompileSourceBuildPhase,
        #       CopyResourcesBuildPhase
        #   ])
        # end
        #
        # it 'should return correct generator for file reference' do
        #   allow(Registry).to receive(:build_phase_generators).and_return([BuildPhase])
        #
        #   file_reference = double()
        #   generator = Registry.generator_for_file_reference(file_reference)
        #
        #   expect(generator).to be_a(BuildPhase)
        # end
      end
    end
  end
end
