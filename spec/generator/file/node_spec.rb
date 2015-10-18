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

        context "when creating children" do

          context "with file path" do

            before :each do
              @target = double()
              @node = Node.new
              @child = @node.create_children_with_path("./file", @target)
            end

            it 'should create child' do
              expect(@child).not_to be_nil
            end

            it 'should store child' do
              expect(@node.children.count).to eq(1)
            end

            it 'should set the component' do
              expect(@child.component).to eq("file")
            end

            it 'should set the path' do
              expect(@child.path).to eq("./file")
            end

            it 'should set the parent' do
              expect(@child.parent).to be(@node)
            end

            it 'should add the target' do
              expect(@child.targets).to include(@target)
            end

          end

          context "with folder path" do

            before :each do
              @target = double()
              @node = Node.new
              @child = @node.create_children_with_path("./folder/file", @target)
            end

            it 'should create child' do
              expect(@child).not_to be_nil
            end

            it 'should store child' do
              expect(@node.children.count).to eq(1)
            end

            it 'should set the component' do
              expect(@child.component).to eq("folder")
            end

            it 'should set the path' do
              expect(@child.path).to eq("./folder/file")
            end

            it 'should set the parent' do
              expect(@child.parent).to be(@node)
            end

            it 'should add the target' do
              expect(@child.targets).to include(@target)
            end

          end

          context "with two files under same folder" do

            before :each do
              @target = double()
              @node = Node.new
              @child = @node.create_children_with_path("./folder/file", @target)
              @child2 = @node.create_children_with_path("./folder/file2", @target)
            end

            it 'should create child' do
              expect(@child).not_to be_nil
            end

            it 'should store one child' do
              expect(@node.children.count).to eq(1)
            end

            it 'should set the component' do
              expect(@child.component).to eq("folder")
            end

            it 'should set the path' do
              expect(@child.path).to eq("./folder/file")
            end

            it 'should set the parent' do
              expect(@child.parent).to be(@node)
            end

            it 'should add the target' do
              expect(@child.targets).to include(@target)
            end

            it 'should store the target once' do
              expect(@child.targets.count).to eq(1)
            end

          end

        end
      end
    end
  end
end
