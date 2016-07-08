require 'spec_helper'

module Xcodeproj
  class Project
    module Object
      #   def child_for_path(path)
      #     path = path.split('/').keep_if do |c|
      #       c != '.'
      #     end unless path.is_a?(Array)
      #
      #     child_name = path.shift
      #     child = children.find { |c| c.display_name == child_name }
      #
      #     if child.nil?
      #       child = new_group(child_name)
      #       child.path = child_name
      #     end
      #
      #     if path.empty?
      #       child
      #     else
      #       child.child_for_path(path)
      #     end
      #  end
      #
      #   def dirname
      #     return '.' if parent.is_a? PBXProject
      #     return parent.dirname.to_s if is_a? PBXVariantGroup
      #     "#{parent.dirname}/#{display_name}"
      #   end

        describe PBXGroup do

          it 'should return correct dirname when parent is project' do
            group = PBXGroup.new
            group.parent = PBXProject.new

            expect(group.dirname).to eq('.')
          end

          it 'should return correct dirname when parent is group' do
            parent = PBXGroup.new
            parent.path = 'Hello'

            group = PBXGroup.new
            group.path = 'World'
            group.parent = parent

            expect(group.dirname).to eq('Hello/World')
          end

          it 'should return correct dirname when parent is variant group' do
            parent = PBXGroup.new
            parent.path = 'Hello'

            group = PBXVariantGroup.new
            group.parent = parent

            expect(group.dirname).to eq('Hello')
          end

          it '' do
            expect(Command.version).to eq(VERSION)
          end

          # TODO: Test other commnands
        end
      end
   end
end
