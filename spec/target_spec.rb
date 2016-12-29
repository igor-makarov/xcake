require 'spec_helper'

module Xcake
  describe Target do
    before :each do
      project = double('Project').as_null_object
      @target = Target.new(project)
      @target.name = 'Test'
    end

    context 'when creating target' do
      context 'for ios' do
        before :each do
          @target.platform = :ios
        end

        it 'should set default system frameworks' do
          expect(@target.system_frameworks).to eq(%w(Foundation UIKit))
        end
      end

      context 'for tvos' do
        before :each do
          @target.platform = :tvos
        end

        it 'should set default system frameworks' do
          expect(@target.system_frameworks).to eq(%w(Foundation UIKit))
        end
      end

      context 'for watchos' do
        before :each do
          @target.platform = :watchos
        end

        it 'should set default system frameworks' do
          expect(@target.system_frameworks).to eq(%w(Foundation UIKit WatchKit))
        end
      end

      context 'for osx' do
        before :each do
          @target.platform = :osx
        end

        it 'should set default system frameworks' do
          expect(@target.system_frameworks).to eq(%w(Cocoa))
        end
      end
    end

    it 'should have the correct default include files' do
      @target.name = 'test'
      expect(@target.include_files).to eq(%w(./test/**/*.*))
    end

    it 'should have the correct default exclude files' do
      expect(@target.exclude_files).to eq([])
    end

    #TODO: Move these into configurable_spec.rb

    it 'should have the correct default debug settings' do
      @target.platform = :ios
      @target.deployment_target = 8.0
      @target.type = :application
      @target.language = :objc

      settings = Xcodeproj::Project::ProjectHelper.common_build_settings(:debug, @target.platform, @target.deployment_target.to_s, @target.type, @target.language)
      settings['INFOPLIST_FILE'] = 'Test/Supporting Files/Info.plist'
      settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Onone'

      expect(@target.default_debug_settings).to eq(settings)
    end

    it 'should have the correct default release settings' do
      @target.platform = :ios
      @target.deployment_target = 8.0
      @target.type = :application
      @target.language = :objc

      settings = Xcodeproj::Project::ProjectHelper.common_build_settings(:release, @target.platform, @target.deployment_target.to_s, @target.type, @target.language)
      settings['INFOPLIST_FILE'] = 'Test/Supporting Files/Info.plist'
      expect(@target.default_release_settings).to eq(settings)
    end
  end
end
