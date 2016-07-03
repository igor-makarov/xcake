require 'spec_helper'

module Xcake
  describe Configuration do
    context 'when created' do
      before :each do
        @name = :configuration
        @configuration = Configuration.new(@name)
      end

      it 'should set the name' do
        expect(@configuration.name).to eq(@name.to_s)
      end

      it 'should set the settings' do
        expect(@configuration.settings).not_to be(nil)
      end
    end
  end
end
