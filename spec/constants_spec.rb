require 'spec_helper'

module Xcake
  describe Constants do
    before do
      @helper = Xcake::Constants
    end

    describe '::common_build_settings' do
      it 'returns the build settings for a bundle' do
        settings = @helper.common_build_settings(:release, :osx, nil, Xcodeproj::Constants::PRODUCT_TYPE_UTI[:bundle])
        expect(settings['COMBINE_HIDPI_IMAGES']).to eq('YES')
      end

      it 'returns the build settings from xcake' do
        settings = @helper.common_build_settings(:release, :osx, nil, Xcodeproj::Constants::PRODUCT_TYPE_UTI[:unit_test_bundle])
        expect(settings['LD_RUNPATH_SEARCH_PATHS']).to eq([
                                                            '$(inherited)',
                                                            '@executable_path/../Frameworks',
                                                            '@loader_path/../Frameworks'
                                                          ])
      end

      it 'returns a deep copy of the common build settings' do
        settings1 = @helper.common_build_settings(:release, :ios, nil, nil)
        settings2 = @helper.common_build_settings(:release, :ios, nil, nil)

        expect(settings1.object_id).to_not eq(settings2.object_id)
        expect(settings1['SDKROOT'].object_id).to_not eq(settings2['SDKROOT'].object_id)
        expect(settings1['SDKROOT'][1].object_id).to_not eq(settings2['SDKROOT'][1].object_id)
      end
    end
  end
end
