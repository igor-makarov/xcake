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
          @path = Pathname.new '.'
        end

        it 'should return file reference for file' do
          file = @project.file_reference_for_path(@path)
          expect(file).to_not be(nil)
        end

        it 'should return file reference for localized file' do
          @path = Pathname.new './en.lproj/Hi.txt'

          file = @project.file_reference_for_path(@path)
          expect(file).to_not be(nil)
        end

        it 'should set path with folder and filename for localized file' do
          path = Pathname.new './en.lproj/Hi.txt'

          file = @project.file_reference_for_path(path)
          expect(file.path).to eq('en.lproj/Hi.txt')
        end

        it 'should set path with filename reference for file' do
          path = Pathname.new './Hi.txt'

          file = @project.file_reference_for_path(path)
          expect(file.path).to eq('Hi.txt')
        end

        it 'should set path with filename reference for file inside a folder' do
          path = Pathname.new './Folder/Hi.txt'

          file = @project.file_reference_for_path(path)
          expect(file.path).to eq('Hi.txt')
        end

        it 'should not add duplicate file reference' do
          path = Pathname.new './Folder/Hi.txt'

          file_ref_a = @project.file_reference_for_path(path)
          file_ref_b = @project.file_reference_for_path(path)

          expect(file_ref_a.uuid).to eq(file_ref_b.uuid)
        end

        it 'should not reuse file reference with same name under different folder' do
          path_a = Pathname.new './FolderA/Hi.txt'
          path_b = Pathname.new './FolderB/Hi.txt'

          file_ref_a = @project.file_reference_for_path(path_a)
          file_ref_b = @project.file_reference_for_path(path_b)

          expect(file_ref_a.uuid).to_not eq(file_ref_b.uuid)
        end
      end

      context 'when creating group for file reference' do
        it 'should use main group for file at root of project' do
          path = Pathname.new './Hello.txt'
          group = @project.group_for_file_reference_path(path)

          expect(group).to eq(@project.main_group)
        end

        it 'should use variant group for localized file' do
          path = Pathname.new './en.lproj/Hello.txt'
          group = @project.group_for_file_reference_path(path)

          expect(group).to be_kind_of(::Xcodeproj::Project::Object::PBXVariantGroup)
        end

        it 'should use same group for localized file for multiple languages' do
          en_path = Pathname.new './en.lproj/Hello.txt'
          fr_path = Pathname.new './fr.lproj/Hello.txt'
          en_group = @project.group_for_file_reference_path(en_path)
          fr_group = @project.group_for_file_reference_path(fr_path)

          expect(en_group).to eq(fr_group)
        end

        it 'should use group for file' do
          path = Pathname.new './Hello.txt'
          group = @project.group_for_file_reference_path(path)

          expect(group).to be_kind_of(::Xcodeproj::Project::Object::PBXGroup)
        end

        it 'should not set path of group for localized folder with file' do
          path = Pathname.new './en.lproj/Hello.txt'
          group = @project.group_for_file_reference_path(path)

          expect(group.path).to be(nil)
        end

        it 'should set name to filename for group localized folder with file' do
          path = Pathname.new './en.lproj/Hello.txt'
          group = @project.group_for_file_reference_path(path)

          expect(group.name).to eq('Hello.txt')
        end

        it 'should set path to folder for group for folder with file' do
          path = Pathname.new './Folder/Hello.txt'
          group = @project.group_for_file_reference_path(path)

          expect(group.path).to eq('Folder')
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

      it 'should find unit test target for target' do
        target = double('Target')
        allow(target).to receive(:name).and_return('app')

        unit_test_target = double('Unit Test Target')
        allow(unit_test_target).to receive(:name).and_return('appTests')

        allow(@project).to receive(:targets).and_return([target, unit_test_target])
        found_target = @project.find_unit_test_target_for_target(target)
        expect(found_target).to be(unit_test_target)
      end

      it 'should find ui test target for target' do
        target = double('Target')
        allow(target).to receive(:name).and_return('app')

        ui_test_target = double('UI Test Target')
        allow(ui_test_target).to receive(:name).and_return('appUITests')

        allow(@project).to receive(:targets).and_return([target, ui_test_target])
        found_target = @project.find_ui_test_target_for_target(target)
        expect(found_target).to be(ui_test_target)
      end
    end
  end
end
