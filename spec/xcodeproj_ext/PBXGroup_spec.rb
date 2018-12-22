require 'spec_helper'

module Xcodeproj
  class Project
    module Object
      describe PBXGroup do
        before :each do
          @project = Xcake::Xcode::Project.new('.', false)
          @root_group = PBXGroup.new(@project, '')
          @root_group.name = 'Main Group'
          @root_group.add_referrer(@project)
        end

        it 'should return correct dirname when parent is project' do
          group = PBXGroup.new(@project, '')
          group.add_referrer(@root_group)

          expect(group.dirname).to eq('.')
        end

        it 'should return correct dirname when parent is group' do
          parent = PBXGroup.new(@project, '')
          parent.path = 'Hello'
          parent.add_referrer(@root_group)

          group = PBXVariantGroup.new(@project, '')
          group.add_referrer(parent)

          expect(group.dirname).to eq('./Hello')
        end

        it 'should return correct dirname when variant group' do
          parent = PBXGroup.new(@project, '')
          parent.path = 'Folder'
          parent.add_referrer(@root_group)

          group = PBXVariantGroup.new(@project, '')
          group.add_referrer(parent)

          expect(group.dirname).to eq('./Folder')
        end

        context 'when fetching child for a path' do
          before :each do
            @root_group.add_referrer(@project)
            @child_group = @root_group.child_for_path('./Child/Path/')
          end

          it 'path should be set to component name' do
            expect(@child_group.path).to eq('Path')
          end

          it 'parent path should be set to component name' do
            expect(@child_group.parent.path).to eq('Child')
          end
        end
      end
    end
  end
end
