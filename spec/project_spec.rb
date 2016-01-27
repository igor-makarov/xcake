require 'spec_helper'

module Xcake
  describe Project do

    it "should have a default project name" do
      project = Project.new

      expect(project.name).to eq("Project")
    end

    it "should set project name" do
      project = Project.new("Test")

      expect(project.name).to eq("Test")
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

    it "should have the correct default settings" do
      @project = Project.new

      common_settings = Xcodeproj::Constants::PROJECT_DEFAULT_BUILD_SETTINGS
      settings = Xcodeproj::Project::ProjectHelper.deep_dup(common_settings[:all])

      expect(@project.default_settings).to eq(settings)
    end

    it "should have the correct default debug settings" do
      @project = Project.new

      common_settings = Xcodeproj::Constants::PROJECT_DEFAULT_BUILD_SETTINGS
      settings = Xcodeproj::Project::ProjectHelper.deep_dup(common_settings[:all])
      settings = settings.merge!(Xcodeproj::Project::ProjectHelper.deep_dup(common_settings[:debug]))

      expect(@project.default_debug_settings).to eq(settings)
    end

    it "should have the correct default release settings" do
      @project = Project.new

      common_settings = Xcodeproj::Constants::PROJECT_DEFAULT_BUILD_SETTINGS
      settings = Xcodeproj::Project::ProjectHelper.deep_dup(common_settings[:all])
      settings = settings.merge!(Xcodeproj::Project::ProjectHelper.deep_dup(common_settings[:release]))

      expect(@project.default_release_settings).to eq(settings)
    end
  end
end
