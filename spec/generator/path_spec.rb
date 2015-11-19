require 'spec_helper'

module Xcake
  module Generator
    describe Path do

      before :each do
          @project = double()
          @generator = Path.new(@project)
      end

      it 'should store the project' do
        expect(@generator.project).to be(@project)
      end

      context 'when root node' do

        it 'should return main group' do

          main_group = double()
          allow(@project).to receive(:main_group).and_return(main_group)

          node = double()
          allow(node).to receive(:parent)

          group = @generator.group_for_node(node)
          expect(group).to be(@project.main_group)
        end
      end

      #Group For Node

      #Visit node
    end
  end
end
