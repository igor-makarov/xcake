require 'spec_helper'

module Xcake
  describe Project do
    before :each do
      @project = Project.new('Test')
    end

    it 'should have a default project name' do
      project = Project.new

      expect(project.name).to eq('Project')
    end

    it 'should set project name' do
      expect(@project.name).to eq('Test')
    end

    it 'should initialize targets' do
      expect(@project.targets).not_to be(nil)
    end

    it 'should store targets when created' do
      @project.target
      expect(@project.targets.count).to eq(1)
    end

    it 'should have the correct default settings' do
      common_settings = Xcodeproj::Constants::PROJECT_DEFAULT_BUILD_SETTINGS
      settings = Xcodeproj::Project::ProjectHelper.deep_dup(common_settings[:all])

      expect(@project.default_settings).to eq(settings)
    end

    it 'should have the correct default debug settings' do
      common_settings = Xcodeproj::Constants::PROJECT_DEFAULT_BUILD_SETTINGS
      settings = Xcodeproj::Project::ProjectHelper.deep_dup(common_settings[:all])
      settings = settings.merge!(Xcodeproj::Project::ProjectHelper.deep_dup(common_settings[:debug]))

      expect(@project.default_debug_settings).to eq(settings)
    end

    it 'should have the correct default release settings' do
      common_settings = Xcodeproj::Constants::PROJECT_DEFAULT_BUILD_SETTINGS
      settings = Xcodeproj::Project::ProjectHelper.deep_dup(common_settings[:all])
      settings = settings.merge!(Xcodeproj::Project::ProjectHelper.deep_dup(common_settings[:release]))

      expect(@project.default_release_settings).to eq(settings)
    end

    context 'when creating target' do
      before :each do
        @project.debug_configuration
        @project.release_configuration

        @target = @project.target
      end

      it 'target should inherit all configurations' do
        expect(@target.all_configurations.count).to eq(2)
      end
    end
  end
end
