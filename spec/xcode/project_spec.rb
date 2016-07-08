require 'spec_helper'
require 'pathname'
require 'xcodeproj'

module Xcake
  module Xcode
    describe Project do
      before :each do
        @project = Project.new('.', true)
        @project.setup_for_xcake
      end

      context 'when creating file reference' do

        before :each do
          @path = Pathname.new "."
        end

        it 'should return nil for directory' do
          allow(File).to receive(:directory?).and_return(true)

          file = @project.file_reference_for_path(@path)
          expect(file).to be(nil)
        end

        it 'should return file reference for file' do
          allow(File).to receive(:directory?).and_return(false)

          file = @project.file_reference_for_path(@path)
          expect(file).to_not be(nil)
        end

        it 'should return file reference for localized file' do
          allow(File).to receive(:directory?).and_return(false)
          @path = Pathname.new "./en.lproj/Hi.txt"

          file = @project.file_reference_for_path(@path)
          expect(file).to_not be(nil)
        end

        # Verify Name And Path

        it 'should return file reference for g localized file' do
          allow(File).to receive(:directory?).and_return(false)
          @path = Pathname.new "./en.lproj/Hi.txt"

          file = @project.file_reference_for_path(@path)
          expect(file).to_not be(nil)
        end

        it 'should return file reference for g file' do
          allow(File).to receive(:directory?).and_return(false)
          @path = Pathname.new "./en.lproj/Hi.txt"

          file = @project.file_reference_for_path(@path)
          expect(file).to_not be(nil)
        end

        it 'should return file reference for m file' do
          allow(File).to receive(:directory?).and_return(false)
          @path = Pathname.new "./en.lproj/Hi.txt"

          file = @project.file_reference_for_path(@path)
          expect(file).to_not be(nil)
        end
      end

      context 'when creating group for file reference' do

        it 'should use main group for file at root of project' do
          path = Pathname.new "./Hello.txt"
          group = @project.group_for_file_reference_path(path)

          expect(group).to eq(@project.main_group)
        end

        it 'should use variant group for localized file' do
          path = Pathname.new "./en.lproj/Hello.txt"
          group = @project.group_for_file_reference_path(path)

          expect(group).to be_kind_of(::Xcodeproj::Project::Object::PBXVariantGroup)
        end

        it 'should use same group for localized file for multiple languages' do
          en_path = Pathname.new "./en.lproj/Hello.txt"
          fr_path = Pathname.new "./fr.lproj/Hello.txt"
          en_group = @project.group_for_file_reference_path(en_path)
          fr_group = @project.group_for_file_reference_path(fr_path)

          expect(en_group).to eq(fr_group)
        end

        it 'should use group for file' do
          path = Pathname.new "./Hello.txt"
          group = @project.group_for_file_reference_path(path)

          expect(group).to be_kind_of(::Xcodeproj::Project::Object::PBXGroup)
        end

        # TODO: Verify Group Paths

        it 'should use mgroup for file' do
          path = Pathname.new "./Hello.txt"
          group = @project.group_for_file_reference_path(path)

          expect(group).to be_kind_of(::Xcodeproj::Project::Object::PBXGroup)
        end

        it 'should use vgroup for file' do
          path = Pathname.new "./Hello.txt"
          group = @project.group_for_file_reference_path(path)

          expect(group).to be_kind_of(::Xcodeproj::Project::Object::PBXGroup)
        end

        it 'should use vgroup for file' do
          path = Pathname.new "./Hello.txt"
          group = @project.group_for_file_reference_path(path)

          expect(group).to be_kind_of(::Xcodeproj::Project::Object::PBXGroup)
        end
      end

      it 'should set the root object when setup' do
        expect(@project.root_object).to_not be(nil)
      end

      it 'should set the configuration list when setup' do
        expect(@project.root_object.build_configuration_list).to_not be(nil)
      end

      it 'should return object version as default' do
        expect(@project.object_version).to eq(Xcodeproj::Constants::DEFAULT_OBJECT_VERSION.to_s)
      end

      it 'should have a scheme list' do
        expect(@project.scheme_list).to_not be(nil)
      end

      it 'should find unit test target for target' do
        target = double('Target')
        allow(target).to receive(:name).and_return('app')

        unit_test_target = double('Unit Test Target')
        allow(unit_test_target).to receive(:name).and_return('appTests')

        allow(@project).to receive(:targets).and_return([target, unit_test_target])
        found_target = @project.find_unit_test_target_for_target(target)
        expect(found_target).to be(unit_test_target)
      end

      context 'when recreating schemes' do
        before :each do
          @scheme_list = double('Scheme List').as_null_object
          allow(@project).to receive(:scheme_list).and_return(@scheme_list)
        end

        it 'should tell scheme list to recreate schemes' do
          expect(@scheme_list).to receive(:recreate_schemes)
          @project.recreate_user_schemes
        end

        it 'should save scheme list' do
          expect(@scheme_list).to receive(:save).with(@project.path)
          @project.recreate_user_schemes
        end
      end
    end

    # TODO: Test object generation
  end
end
