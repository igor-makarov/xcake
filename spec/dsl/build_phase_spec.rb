require 'spec_helper'

module Xcake
  describe BuildPhase do
    before :each do
      @phase = BuildPhase.new
    end

    it 'should raise error when accessing build phase type' do
      expect { @phase.build_phase_type }.to raise_error
    end

    it 'should raise error when configuring native target' do
      expect { @phase.configure_native_build_phase(nil, nil) }.to raise_error
    end
  end
end
