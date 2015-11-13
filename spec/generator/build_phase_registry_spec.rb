require 'spec_helper'

module Xcake
  module Generator
    class BuildPhase
      describe Registry do

        it 'should return registered generators in correct order' do
          expect(Registry.build_phase_generators).to eq([
              CompileSourceBuildPhase,
              CopyResourcesBuildPhase
          ])
        end
      end
    end
  end
end
