require 'spec_helper'

module Xcake
    describe Constants do

        before do
            @helper = Xcake::Constants
        end

        describe '::common_build_settings' do
            it 'returns the build settings for an application by default' do
                settings = @helper.common_build_settings(:release, :ios, nil, nil)
                expect(settings['CODE_SIGN_IDENTITY[sdk=iphoneos*]']).to eq('iPhone Developer')
            end

            it 'returns the build settings for an application' do
                settings = @helper.common_build_settings(:release, :ios, nil, Xcodeproj::Constants::PRODUCT_TYPE_UTI[:application])
                expect(settings['CODE_SIGN_IDENTITY[sdk=iphoneos*]']).to eq('iPhone Developer')
            end

            it 'returns the build settings for a bundle' do
                settings = @helper.common_build_settings(:release, :osx, nil, Xcodeproj::Constants::PRODUCT_TYPE_UTI[:bundle])
                expect(settings['COMBINE_HIDPI_IMAGES']).to eq('YES')
            end

             it 'returns the build settings from xcake' do
                settings = @helper.common_build_settings(:release, :osx, nil, Xcodeproj::Constants::PRODUCT_TYPE_UTI[:bundle])
                expect(settings['LD_RUNPATH_SEARCH_PATHS']).to eq([
                    '$(inherited)',
                    '@executable_path/../Frameworks',
                    '@loader_path/../Frameworks'
                ])
            end

            it 'returns a deep copy of the common build settings' do
                settings_1 = @helper.common_build_settings(:release, :ios, nil, nil)
                settings_2 = @helper.common_build_settings(:release, :ios, nil, nil)

                expect(settings_1.object_id).to_not eq(settings_2.object_id)
                expect(settings_1['SDKROOT'].object_id).to_not eq(settings_2['SDKROOT'].object_id)
                expect(settings_1['SDKROOT'][1].object_id).to_not eq(settings_2['SDKROOT'][1].object_id)
            end
        end
    end
end