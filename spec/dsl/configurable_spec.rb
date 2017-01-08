require 'spec_helper'

module Xcake
  describe Configurable do
    before :each do
      @configurable = Object.new
      @configurable.extend(Configurable)

      allow(@configurable).to receive(:default_debug_settings).and_return(DEFAULT_SETTING: 'DEFAULT_VALUE')

      allow(@configurable).to receive(:default_release_settings).and_return(DEFAULT_SETTING: 'DEFAULT_VALUE')
    end

    context 'when creating debug configuration' do
      before :each do
        @configuration = @configurable.debug_configuration :Debug
      end

      it 'should store build configuration' do
        expect(@configurable.all_configurations.count).to eq(1)
      end

      it 'should use that configuration if no name is specified' do
        expect(@configurable.debug_configuration).to eq(@configuration)
      end

      context 'that already exists' do
        before :each do
          @duplicate_configuration = @configurable.debug_configuration :Debug
        end

        it 'should return same build configuration' do
          expect(@duplicate_configuration).to be(@configuration)
        end
      end
    end

    context 'when creating configurations for the first time' do
      context 'creating a debug configuration' do
        it 'should create a configuration if a name is specified' do
          configuration = @configurable.debug_configuration(:Debug)
          expect(@configurable.debug_configuration(:Debug)).to eq(configuration)
        end

        it 'should name the configuration if a name is specified' do
          configuration = @configurable.debug_configuration(:Debug)
          expect(configuration.name).to eq('Debug')
        end

        it 'should create a configuration even if no name is specified' do
          configuration = @configurable.debug_configuration
          expect(@configurable.debug_configuration).to eq(configuration)
        end

        it 'should name the configuration even if no name is specified' do
          configuration = @configurable.debug_configuration
          expect(configuration.name).to eq('Debug')
        end
      end

      context 'creating a release configuration' do
        it 'should create a configuration if a name is specified' do
          configuration = @configurable.release_configuration(:Release)
          expect(@configurable.release_configuration(:Release)).to \
            eq(configuration)
        end

        it 'should name the configuration if a name is specified' do
          configuration = @configurable.release_configuration(:Release)
          expect(configuration.name).to eq('Release')
        end

        it 'should create a configuration even if no name is specified' do
          configuration = @configurable.release_configuration
          expect(@configurable.release_configuration).to eq(configuration)
        end

        it 'should name the configuration even if no name is specified' do
          configuration = @configurable.release_configuration
          expect(configuration.name).to eq('Release')
        end
      end
    end

    context 'when creating release configuration' do
      before :each do
        @configuration = @configurable.release_configuration :Release
      end

      it 'should store build configuration' do
        expect(@configurable.all_configurations.count).to eq(1)
      end

      it 'should use that configuration if no name is specified' do
        expect(@configurable.release_configuration).to eq(@configuration)
      end

      context 'that already exists' do
        before :each do
          @duplicate_configuration = @configurable.release_configuration :Release
        end

        it 'should return same build configuration' do
          expect(@duplicate_configuration).to be(@configuration)
        end
      end
    end

    context 'when accessing all configurations' do
      before :each do
        @release_configuration = @configurable.release_configuration
        @debug_configuration = @configurable.debug_configuration

        @configurable.all_configurations.each do |c|
          c.settings[:ALL_SETTING] = 'ALL_VALUE'
        end
      end

      context 'for debug' do
        before :each do
          @debug_configuration.settings[:CUSTOM_SETTING] = 'CUSTOM_VALUE'
        end

        it 'should merge in default settings' do
          expect(@debug_configuration.settings[:DEFAULT_SETTING]).to eq('DEFAULT_VALUE')
        end

        it 'should merge in all settings' do
          expect(@debug_configuration.settings[:ALL_SETTING]).to eq('ALL_VALUE')
        end

        it 'should merge in configuration settings' do
          expect(@debug_configuration.settings[:CUSTOM_SETTING]).to eq('CUSTOM_VALUE')
        end
      end

      context 'for release' do
        before :each do
          @release_configuration.settings[:CUSTOM_SETTING] = 'CUSTOM_VALUE'
        end

        it 'should merge in default settings' do
          expect(@release_configuration.settings[:DEFAULT_SETTING]).to eq('DEFAULT_VALUE')
        end

        it 'should merge in all settings' do
          expect(@release_configuration.settings[:ALL_SETTING]).to eq('ALL_VALUE')
        end

        it 'should merge in custom settings' do
          expect(@release_configuration.settings[:CUSTOM_SETTING]).to eq('CUSTOM_VALUE')
        end
      end

      it 'should have same combined number of configurations' do
        expect(@configurable.all_configurations.count).to be(2)
      end
    end
  end
end
