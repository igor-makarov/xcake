require 'spec_helper'

module Xcake
  module Generator
    class BuildPhase
      describe Registry do
        it 'should return registered generators in correct order' do
          expect(Registry.build_phase_generators).to eq([
              CompileSourceBuildPhase,
              CopyResourcesBuildPhase,
              HeaderFileBuildPhase
          ])
        end

        it 'should return correct generator for node' do
          allow(Registry).to receive(:build_phase_generators).and_return([BuildPhase])

          node = double()
          generator = Registry.generator_for_node(node)

          expect(generator).to eq(BuildPhase)
        end
      end
    end
  end
end
