require "spec_helper"

module Xcake
  module Generator
    describe CompileXCDataModelBuildPhase do
      before :each do
        @node = double("Node").as_null_object
      end

      it "should not able to install folder" do
        folder_path = "Folder/"

        allow(@node).to receive(:path).and_return(folder_path)
        allow(File).to receive(:directory?).with(folder_path).and_return(true)

        expect(CompileXCDataModelBuildPhase.can_install_node(@node)).to be(false)
      end

      it "should be able to install xcdatamodel foler" do
        folder_path = "Model.xcdatamodel"

        allow(@node).to receive(:path).and_return(folder_path)
        allow(File).to receive(:directory?).with(folder_path).and_return(true)

        expect(CompileXCDataModelBuildPhase.can_install_node(@node)).to be(true)
      end

      it "should remove children for node" do
        expect(@node).to receive(:children=).with([])

        project = double("Project").as_null_object

        build_phase = CompileXCDataModelBuildPhase.new(project)
        build_phase.visit_node(@node)
      end
    end
  end
end
