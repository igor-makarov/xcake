require 'spec_helper'

module Xcake
  describe Project do

    it "should have a default project name" do
      project = Project.new

      expect(project.project_name).to eq("Project")
    end

    it "should set project name" do
      project = Project.new("Test")

      expect(project.project_name).to eq("Test")
    end

    it "should initialize targets" do
      project = Project.new

      expect(project.targets).not_to be(nil)
    end

    it "should store targets when created" do
      project = Project.new do |c|
        c.target
      end

      expect(project.targets.count).to eq(1)
    end

    context "when creating application" do
      before :each do
        @project = Project.new do |c|
          @target = c.application_for :ios, 8.0
        end
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

        it "should set lanuggae" do
          expect(@target.language).to eq(:swift)
        end
      end
    end
  end
end
