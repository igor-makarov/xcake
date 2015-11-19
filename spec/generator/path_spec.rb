require 'spec_helper'

module Xcake
  module Generator
    describe Path do

      it 'should store the project' do

        project = double()
        generator = Path.new(project)

        expect(generator.project).to be(project)
      end

      context 'when root node' do

        it 'should return main group' do

          main_group = double()
          project = double()
          allow(project).to receive(:main_group).and_return(main_group)

          node = double()
          allow(node).to receive(:parent)

          generator = Path.new(project)

          group = generator.group_for_node(node)
          expect(group).to be(project.main_group)
        end
      end

      #Group For Node

      #Visit node
    end
  end
end
