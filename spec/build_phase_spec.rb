require 'spec_helper'

module Xcake
  describe BuildPhase do

    before :each do
      @phase = BuildPhase.new
    end
    
    it 'should raise error when accessing build phase type' do
        expect { @phase.build_phase_type }.to raise_error
    end

    it 'should set name when configuring native build phase' do
        native_build_phase = double('Native Build Phase')
        @phase.name = "Name"

        expect(native_build_phase).to receive(:name=).with(@phase.name)
        @phase.configure_native_build_phase(native_build_phase, nil)
    end
  end
end
