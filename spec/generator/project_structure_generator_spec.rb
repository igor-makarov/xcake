require "spec_helper"

module Xcake
  describe ProjectStructureGenerator do
    before :each do
      @context = double("Context")
      @generator = ProjectStructureGenerator.new(@context)
    end

    context "when resolving project with no configurations" do
      before :each do
        @project = double("Project").as_null_object

        allow(@project).to receive(:debug_configurations).and_return([])
        allow(@project).to receive(:release_configurations).and_return([])
      end

      it "should create a default debug configuration" do
        expect(@project).to receive(:debug_configuration).with(:Debug)
        @generator.visit_project(@project)
      end

      it "should create a default release configuration" do
        expect(@project).to receive(:release_configuration).with(:Release)
        @generator.visit_project(@project)
      end

      it "should store project" do
        @generator.visit_project(@project)
        expect(@generator.project).to be(@project)
      end
    end

    context "when resolving target with no configurations" do
      before :each do
        @target = double("Target").as_null_object

        @debug_name = "Debug"
        @release_name = "Release"

        @debug_configuration = double("Debug Configuration")
        allow(@debug_configuration).to receive(:name).and_return(@debug_name)

        @release_configuration = double("Debug Configuration")
        allow(@release_configuration).to receive(:name).and_return(@release_name)

        allow(@project).to receive(:debug_configurations).and_return([@debug_configuration])
        allow(@project).to receive(:release_configurations).and_return([@release_configuration])
      end

      it "should propogate debug configurations" do
        expect(@target).to receive(:debug_configuration).with(@debug_name)
        @generator.visit_target(@target)
      end

      it "should propogate release configurations" do
        expect(@target).to receive(:release_configuration).with(@release_name)
        @generator.visit_target(@target)
      end
    end
  end
end
