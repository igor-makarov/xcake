require 'spec_helper'
require 'fileutils'
require 'tmpdir'

module Xcake
  describe XcodeprojContext do
    before :each do
      @context = XcodeprojContext.new
      @project_path = './Name.xcodeproj'
    end

    context 'when creating a build phase' do
      it 'should create new build phase' do
      end
    end

    context 'when creating a project' do
      before :each do
        @project_dsl = double('Project')
        allow(@project_dsl).to receive(:name).and_return('Name')
      end

      it 'should set correct path' do
        project = @context.create_object_for_project(@project_dsl)
        expect(project.path.to_s).to eq(File.expand_path(@project_path))
      end

      it 'should remove old project' do
        Dir.mktmpdir do |dir|
          FileUtils.cd dir do
            old_marker_path = "#{@project_path}/old_marker"

            FileUtils.mkdir(@project_path)
            FileUtils.touch(old_marker_path)

            @project = @context.create_object_for_project(@project_dsl)

            expect(File.exist?(old_marker_path)).to eq(false)
          end
        end
      end
    end

    context 'when creating a target' do
      before :each do
        @context.project = double('Project')
      end

      it 'should create new target' do
        target_dsl = double('Target')
        expect(@context.project).to receive(:new_target).with(target_dsl)
        @context.create_object_for_target(target_dsl)
      end
    end

    context 'when creating a configuration' do
      before :each do
        @context.project = double('Project')
      end

      it 'should create new configuration' do
        configuration_dsl = double('Configuration')
        expect(@context.project).to receive(:new_configuration).with(configuration_dsl)
        @context.create_object_for_configuration(configuration_dsl)
      end
    end

    context 'when creating a scheme' do
      before :each do
        @context.project = double('Project')
      end

      it 'should create new scheme' do
        scheme_dsl = double('Scheme')
        scheme = @context.create_object_for_scheme(scheme_dsl)
        expect(scheme).to be_a(Xcode::Scheme)
      end
    end

    context 'when creating a file reference' do
      before :each do
        @context.project = double('Project')
      end

      it 'should create new group' do
        file = double('File Reference')

        allow(@context.project).to receive(:file_reference_for_path).and_return(file)
        returned_file = @context.file_reference_for_path('path')
        expect(returned_file).to eq(file)
      end
    end

    it 'should return scheme list' do
      scheme_list = @context.scheme_list
      expect(scheme_list).to_not be_nil
    end
  end
end
