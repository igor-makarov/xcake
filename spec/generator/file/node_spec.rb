require 'spec_helper'

module Xcake
  module Generator
    class File
      describe Node do
        it 'initilizes the children' do
          node = Node.new
          expect(node.children).not_to be_nil
        end

        it 'initilizes the targets' do
          node = Node.new
          expect(node.targets).not_to be_nil
        end
      end
    end
  end
end
