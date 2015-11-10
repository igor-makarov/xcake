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
  end
end
