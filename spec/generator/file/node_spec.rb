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

        context "when creating children with path" do

          before :each do
            @node = Node.new
            @child = @node.create_children_with_path("file", nil)
          end

          it 'should create child' do
            expect(@child).not_to be_nil
          end

          it 'should store child' do
            expect(@node.children.count).to be(1)
          end

          it 'should set the component' do
            expect(@child.component).to eq("file")
          end

          it 'should set the path' do
            expect(@child.path).to eq("file")
          end
        end
      end
    end
  end
end
