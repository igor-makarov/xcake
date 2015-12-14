require 'spec_helper'

module Xcake
  describe Project do

    before :each do
      @project = Project.new
    end

    context "when creating application target" do
      before :each do
        @target = @project.application_for :ios, 8.0
      end

      it "should store targets when created" do
        expect(@project.targets.count).to eq(1)
      end

      it "should set type to application" do
        expect(@target.type).to eq(:application)
      end

      it "should set platform" do
        expect(@target.platform).to eq(:ios)
      end

      it "should set deployment target" do
        expect(@target.deployment_target).to eq(8.0)
      end

      it "should default to objective c" do
        expect(@target.language).to eq(:objc)
      end

      context "when specifying language" do

        before :each do
          @project = Project.new do |c|
            @target = c.application_for :ios, 8.0, :swift
          end
        end

        it "should set language" do
          expect(@target.language).to eq(:swift)
        end
      end
    end
  end

  context "when creating unit test target" do
    before :each do
      @target = @project.application_for :ios, 8.0
    end
  end

  context "when creating watch target" do
    before :each do
      @target = @project.application_for :ios, 8.0
    end
  end
end
