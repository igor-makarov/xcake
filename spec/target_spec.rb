require 'spec_helper'

module Xcake
  describe Target do

    context "when creating target" do

      context "for ios" do

        before :each do
          @target = Target.new
          @target.platform = :ios
        end

        it "should set default system frameworks" do
          expect(@target.system_frameworks).to eq(['Foundation', 'UIKit'])
        end
      end

      context "for tvos" do

        before :each do
          @target = Target.new
          @target.platform = :tvos
        end

        it "should set default system frameworks" do
          expect(@target.system_frameworks).to eq(['Foundation', 'UIKit'])
        end
      end

      context "for watchos" do

        before :each do
          @target = Target.new
          @target.platform = :watchos
        end

        it "should set default system frameworks" do
          expect(@target.system_frameworks).to eq(['Foundation', 'UIKit', 'WatchKit'])
        end
      end

      context "for osx" do

        before :each do
          @target = Target.new
          @target.platform = :osx
        end

        it "should set default system frameworks" do
          expect(@target.system_frameworks).to eq(['Cocoa'])
        end
      end
    end

    it "should have the correct default include files" do
      target = Target.new
      target.name = "test"

      expect(target.include_files).to eq("./test/**/*.*")
    end

    it "should have the correct default debug settings" do
      target = Target.new

      target.platform = :ios
      target.deployment_target = 8.0
      target.type = :application
      target.language = :objc

      settings = Xcodeproj::Project::ProjectHelper.common_build_settings(:debug, target.platform, target.deployment_target.to_s, target.type, target.language)
      settings.merge!({
        "INFOPLIST_FILE" => "./$(PRODUCT_NAME)/Supporting Files/Info.plist"
        })

      expect(target.default_debug_settings).to eq(settings)
    end

    it "should have the correct default release settings" do
      target = Target.new

      target.platform = :ios
      target.deployment_target = 8.0
      target.type = :application
      target.language = :objc

      settings = Xcodeproj::Project::ProjectHelper.common_build_settings(:release, target.platform, target.deployment_target.to_s, target.type, target.language)
      settings.merge!({
        "INFOPLIST_FILE" => "./$(PRODUCT_NAME)/Supporting Files/Info.plist"
        })
      expect(target.default_release_settings).to eq(settings)
    end
  end
end
