module Xcake
  class Configuration
    describe PreprocessorDefinitionsSettingProxy do
      before :each do
        @settings = {}
        @key = 'Key'
        @proxy = PreprocessorDefinitionsSettingProxy.new(@settings, @key)
      end

      it 'should set settings' do
        expect(@proxy.settings).to eq(@settings)
      end

      it 'should set key' do
        expect(@proxy.key).to eq(@key)
      end

      it 'should contain inherited by default' do
        expect(@proxy.settings[@key]).to eq(['$(inherited)'])
      end

      it 'should set preprocessoer setting' do
        name = 'name'
        value = 'value'

        @proxy[name] = value
        expect(@proxy.settings[@key]).to include("#{name}=#{value}")
      end
    end
  end
end
