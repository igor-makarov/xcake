require 'spec_helper'

module Xcake
    describe Constants do

        before do
            @helper = Xcodeproj::Constants
        end

        describe '::common_build_settings' do
            it 'returns the build settings for an application by default' do
                settings = @helper.common_build_settings(:release, :ios, nil, nil)
                settings['CODE_SIGN_IDENTITY[sdk=iphoneos*]'].should == 'iPhone Developer'
            end

            it 'returns the build settings for an application' do
                settings = @helper.common_build_settings(:release, :ios, nil, Xcodeproj::Constants::PRODUCT_TYPE_UTI[:application])
                settings['CODE_SIGN_IDENTITY[sdk=iphoneos*]'].should == 'iPhone Developer'
            end

            it 'returns the build settings for a bundle' do
                settings = @helper.common_build_settings(:release, :osx, nil, Xcodeproj::Constants::PRODUCT_TYPE_UTI[:bundle])
                settings['COMBINE_HIDPI_IMAGES'].should == 'YES'
            end

            it 'returns a deep copy of the common build settings' do
                settings_1 = @helper.common_build_settings(:release, :ios, nil, nil)
                settings_2 = @helper.common_build_settings(:release, :ios, nil, nil)

                settings_1.object_id.should.not == settings_2.object_id
                settings_1['SDKROOT'].object_id.should.not == settings_2['SDKROOT'].object_id
                settings_1['SDKROOT'][1].object_id.should.not == settings_2['SDKROOT'][1].object_id
            end
        end

        describe '::deep_dup' do
            it 'creates a copy of a given object' do
                object = 'String'
                copy = @helper.deep_dup(object)
                object.should == copy
                object.object_id.should.not == copy.object_id
            end

            it 'creates a deep copy of an array' do
                object = ['String']
                copy = @helper.deep_dup(object)
                object.should == copy
                object.object_id.should.not == copy.object_id
                object[1].object_id.should.not == copy.object_id[1]
            end

            it 'creates a deep copy of an array' do
                object = { :value => 'String' }
                copy = @helper.deep_dup(object)
                object.should == copy
                object.object_id.should.not == copy.object_id
                object.values[1].object_id.should.not == copy.values.object_id[1]
            end
        end
    end
end