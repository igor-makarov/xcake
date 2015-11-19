require 'spec_helper'

module Xcake
  module Generator
    describe Path do

      before :each do
          @main_group = double()

          @project = double()
          allow(@project).to receive(:main_group).and_return(@main_group)

          @node = double().as_null_object
          allow(@node).to receive(:path).and_return('path')

          @generator = Path.new(@project)
      end

      it 'should store the project' do
        expect(@generator.project).to be(@project)
      end

      context 'when finding group for root node' do

        it 'should return main group' do
          allow(@node).to receive(:parent)

          group = @generator.group_for_node(@node)
          expect(group).to be(@project.main_group)
        end
      end

      context 'when finding group for child node' do

        it 'should return sub group' do
          sub_group = double()

          allow(@main_group).to receive(:find_subpath).with('path', true).and_return(sub_group)
          allow(@node).to receive(:parent).and_return(@node)

          group = @generator.group_for_node(@node)
          expect(group).to be(sub_group)
        end
      end

      context 'when visiting node' do

        it 'should create a reference if a directoy' do

          file_reference = double()
          expect(@main_group).to receive(:new_reference).with(@node.path).and_return(file_reference)

          allow(@generator).to receive(:group_for_node).and_return(@main_group)
          allow(File).to receive(:directory?).and_return(true)
          allow(BuildPhase::Registry).to receive(:generator_for_file_reference)

          @generator.visit_node(@node)

        end

        # group = group_for_node(node)
        # file_reference = group.new_reference(node.path) if File.directory?(node.path)
        #
        # installer = BuildPhase::Registry.generator_for_file_reference(file_reference)
        #
        # node.targets.each do |t|
        #
        #   puts "Added to #{t}"
        #   installer.visit_target(t)
        # end
      end
    end
  end
end
