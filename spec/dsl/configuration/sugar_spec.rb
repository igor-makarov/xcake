require 'spec_helper'

module Xcake
  describe Configurable do
    before :each do
      @configuration = Configuration.new(:test)
    end

    context 'should set supported devices' do
      it 'for iphone only' do
        @configuration.supported_devices = :iphone_only
        expect(@configuration.settings['TARGETED_DEVICE_FAMILY']).to eq('1')
      end

      it 'for ipad only' do
        @configuration.supported_devices = :ipad_only
        expect(@configuration.settings['TARGETED_DEVICE_FAMILY']).to eq('2')
      end

      it 'for universal' do
        @configuration.supported_devices = :universal
        expect(@configuration.settings['TARGETED_DEVICE_FAMILY']).to eq('1,2')
      end
    end

    it 'should set product bundle identifier' do
      identifier = 'identifier'
      @configuration.product_bundle_identifier = identifier
      setting = @configuration.settings['PRODUCT_BUNDLE_IDENTIFIER']
      expect(setting).to eq(identifier)
    end

    context 'when accessing preprocessor definitions' do
      before :each do
        @proxy = @configuration.preprocessor_definitions
      end

      it 'should set key for settings' do
        expect(@proxy.key).to eq('GCC_PREPROCESSOR_DEFINITIONS')
      end

      it 'should set settings for proxy' do
        expect(@proxy.settings).to eq(@configuration.settings)
      end
    end
  end
end
