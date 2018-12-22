require 'spec_helper'

module Xcake
  describe Constants do
    before do
      @helper = Xcake::Constants
    end

    describe '::common_build_settings' do
      it 'returns the additional build settings for from xcake for :ios' do
        [:unit_test_bundle, :ui_test_bundle].each do |target_product_type|
          settings = @helper.common_build_settings(:release, :ios, nil, target_product_type)
          expect(settings['LD_RUNPATH_SEARCH_PATHS']).to eq([
                                                              '$(inherited)',
                                                              '@executable_path/Frameworks',
                                                              '@loader_path/Frameworks'
                                                            ])
        end
      end

      it 'returns the additional build settings for from xcake for :osx' do
        [:unit_test_bundle, :ui_test_bundle].each do |target_product_type|
          settings = @helper.common_build_settings(:release, :osx, nil, target_product_type)
          expect(settings['LD_RUNPATH_SEARCH_PATHS']).to eq([
                                                              '$(inherited)',
                                                              '@executable_path/../Frameworks',
                                                              '@loader_path/../Frameworks'
                                                            ])
        end
      end

      it 'returns a deep copy of the common build settings' do
        settings1 = @helper.common_build_settings(:release, :ios, nil, :unit_test_bundle)
        settings2 = @helper.common_build_settings(:release, :ios, nil, :unit_test_bundle)

        expect(settings1.object_id).to_not eq(settings2.object_id)
        expect(settings1['LD_RUNPATH_SEARCH_PATHS'].object_id).to_not eq(settings2['LD_RUNPATH_SEARCH_PATHS'].object_id)
        expect(settings1['LD_RUNPATH_SEARCH_PATHS'][1].object_id).to_not eq(settings2['LD_RUNPATH_SEARCH_PATHS'][1].object_id)
      end
    end
  end
end
