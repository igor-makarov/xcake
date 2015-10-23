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
              @file = @node.create_children_with_path("./file", @target)
            end

            it 'should create child' do
              expect(@file).not_to be_nil
            end

            it 'should store child' do
              expect(@node.children.count).to eq(1)
            end

            it 'should set the component' do
              expect(@file.component).to eq("file")
            end

            it 'should set the path' do
              expect(@file.path).to eq("./file")
            end

            it 'should set the parent' do
              expect(@file.parent).to be(@node)
            end

            it 'should add the target' do
              expect(@file.targets).to include(@target)
            end

          end

          context "with folder path" do

            before :each do
              @target = double()
              @node = Node.new
              @folder = @node.create_children_with_path("./folder/file", @target)
              @file = @folder.children.first
            end

            it 'should create child' do
              expect(@folder).not_to be_nil
            end

            it 'should store child' do
              expect(@node.children.count).to eq(1)
            end

            it 'should create child of child' do
              expect(@folder.children.count).to eq(1)
            end

            it 'should set the component' do
              expect(@folder.component).to eq("folder")
              expect(@file.component).to eq("file")
            end

            it 'should set the path' do
              expect(@folder.path).to eq("./folder")
              expect(@file.path).to eq("./folder/file")
            end

            it 'should set the parent' do
              expect(@folder.parent).to be(@node)
            end

            it 'should add the target' do
              expect(@folder.targets).to include(@target)
            end

          end

          context "with two files under same folder" do

            before :each do
              @target = double()
              @node = Node.new
              @folder = @node.create_children_with_path("./folder/file", @target)
              @folder2 = @node.create_children_with_path("./folder/file2", @target)
            end

            it 'should create child' do
              expect(@folder).not_to be_nil
            end

            it 'should store one child' do
              expect(@node.children.count).to eq(1)
            end

            it 'should create child of child' do
              expect(@folder.children.count).to eq(2)
            end

            it 'should store the target once' do
              expect(@folder.targets.count).to eq(1)
            end
          end
        end

        context "when removing children" do

          context "with file path" do

            before :each do
              @target = double()
              @node = Node.new
              @node.create_children_with_path("./file", @target)
              @node.remove_children_with_path("./file", @target)
            end

            it 'should remove child' do
              expect(@node.children.count).to eq(0)
            end
          end

          context "with multiple targets and one target is removed" do

            before :each do
              @target = double()
              @target2 = double()
              @node = Node.new
              @file = @node.create_children_with_path("./file", @target)
              @node.create_children_with_path("./file", @target2)
              @node.remove_children_with_path("./file", @target)
            end

            it 'should keep child' do
              expect(@node.children.count).to eq(1)
            end

            it 'should remove correct target' do
              expect(@file.targets.first).to be(@target2)
            end
          end
        end
      end
    end
  end
end
