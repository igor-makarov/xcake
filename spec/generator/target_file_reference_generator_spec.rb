require "spec_helper"

# TODO: Refactor/abstract out node graph
# TODO: Test dependency resolution
# TODO: Project Visiting
# TODO: Node Visiting
module Xcake
  describe TargetFileReferenceGenerator do
    before :each do
      @dsl_target = double("DSL Target")
      @target = double("Target")
      @context = double("Context")
      @generator = TargetFileReferenceGenerator.new(@context)

      allow(@context).to receive(:native_object_for).and_return(@target)
    end

    it "should have correct dependencies" do
      expect(TargetFileReferenceGenerator.dependencies).to eq([TargetGenerator])
    end

    it "should create root node" do
      expect(@generator.root_node).not_to be_nil
    end

    context "when processing files for a target" do
      before :each do
        @target = double("Target").as_null_object

        @native_target = double("Native Target")
        allow(@context).to receive(:native_object_for).and_return(@native_target)
      end

      it "should include files" do
        allow(@target).to receive(:include_files).and_return(["**/*.swift"])
        allow(@target).to receive(:exclude_files).and_return(nil)
        allow(Dir).to receive(:glob).and_return(["File.swift"])

        expect(@generator.root_node).to receive(:create_children_with_path).with(
          "File.swift",
          @native_target
        )

        @generator.process_files_for_target(@target)
      end

      it "should exclude files" do
        allow(@target).to receive(:include_files).and_return(nil)
        allow(@target).to receive(:exclude_files).and_return(["**/*.swift"])
        allow(Dir).to receive(:glob).and_return(["File.swift"])

        expect(@generator.root_node).to receive(:remove_children_with_path).with(
          "File.swift",
          @native_target
        )

        @generator.process_files_for_target(@target)
      end
    end
  end
end
