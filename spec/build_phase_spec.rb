require 'spec_helper'

module Xcake
  describe BuildPhase do
    
    it 'should set name when configuring native build phase' do
        native_build_phase = double('Native Build Phase')
        build_phase = BuildPhase.new
        build_phase.name = "Name"

        expect(native_build_phase).to receive(:name=).with(build_phase.name)
        build_phase.configure_native_build_phase(native_build_phase, nil)
    end
  end
end
