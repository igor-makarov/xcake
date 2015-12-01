require 'spec_helper'

module Xcake
  module Generator
    describe BuildPhase do

      before :each do
          @main_group = double("Main Group")

          @project = double("Project")
          allow(@project).to receive(:main_group).and_return(@main_group)

          @node = double("Node").as_null_object
          @build_phase = BuildPhase.new(@project)
      end

      it "should be able to install node" do
        expect(BuildPhase.can_install_node(@node)).to be(true)
      end

      it "should store the project" do
        expect(@build_phase.project).to eq(@project)
      end

      context 'when finding group for root node' do

        it 'should return main group' do
          allow(@node).to receive(:parent)

          group = @build_phase.group_for_node(@node)
          expect(group).to be(@project.main_group)
        end
      end

      context 'when finding group for child node' do

        it 'should return sub group' do
          sub_group = double("Sub Group")

          allow(@node).to receive(:path).and_return('path')
          allow(@main_group).to receive(:find_subpath).with('path', true).and_return(sub_group)
          allow(@node).to receive(:parent).and_return(@node)

          group = @build_phase.group_for_node(@node)
          expect(group).to be(sub_group)
        end
      end
    end
  end
end
