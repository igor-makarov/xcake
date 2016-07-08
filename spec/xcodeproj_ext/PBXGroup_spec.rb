require 'spec_helper'

module Xcodeproj
  class Project
    module Object
        describe PBXGroup do

          before :each do
            @project = PBXProject.new('.')
            @group = PBXGroup.new(project)
          end

          it 'should return correct dirname when parent is project' do
            expect(@group.dirname).to eq('.')
          end

          it 'should return correct dirname when parent is group' do
            parent = PBXGroup.new(project)
            parent.path = 'Hello'

            @group.path = 'World'
            @group.parent = parent

            expect(@group.dirname).to eq('Hello/World')
          end

          it 'should return correct dirname when parent is variant group' do
            parent = PBXGroup.new(project)
            parent.path = 'Hello'

            @group.parent = parent

            expect(@group.dirname).to eq('Hello')
          end

          context 'when fetching child for a path' do

            before :each do
              @child_group = @group.child_for_path('./Child/Path/')
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
