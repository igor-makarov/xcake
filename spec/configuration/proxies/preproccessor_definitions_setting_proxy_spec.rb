module Xcake
  class Configuration
    describe PreprocessorDefinitionsSettingProxy do

      before :each do
        @setting = double("Setting")
        @proxy = PreprocessorDefinitionsSettingProxy.new(@setting)
      end

      it "should set setting" do
        expect(@proxy.setting).to eq(@setting)
      end
    end
  end
end
