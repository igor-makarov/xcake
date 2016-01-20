require "spec_helper"

module Xcake
  module Generator
    describe Project do

      before :each do
        @generator = Project.new

        @project = double("Project").as_null_object
        allow(@project).to receive(:project_name) { "Project" }
      end

      it "generates the correct output filepath" do
        output_filepath = @generator.output_filepath_for_project(@project)
        expect(output_filepath).to eq("./Project.xcodeproj")
      end

      it "generates the project" do
        @generator.visit_project(@project)
        expect(@generator.project).not_to be_nil
      end

      it "creates a valid context" do
        @generator.visit_project(@project)
        expect(@generator.context).not_to be_nil
      end

      it "should set class prefix" do
        prefix = "XC"

        allow(@project).to receive(:class_prefix).and_return(prefix)
        @generator.visit_project(@project)

        expect(@generator.project.class_prefix).to eq(prefix)
      end

      it "should set organization name" do
        organization = "Xcake Productions"

        allow(@project).to receive(:organization).and_return(organization)
        @generator.visit_project(@project)

        expect(@generator.project.organization).to eq(organization)
      end

      it "should create root node" do
        expect(@generator.root_node).not_to be_nil
      end

      it "should create root node" do
        expect(@generator.root_node).not_to be_nil
      end

      context "when finished parsing project" do

        before :each do
          @project = double("Project").as_null_object
          @root_node = double("Root Node").as_null_object

          @generator.project = @project
          @generator.root_node = @root_node
        end

        it "run path generator on root node" do
          generator = double("Path Generator").as_null_object
          expect(@root_node).to receive(:accept).with(generator)
          allow(Path).to receive(:new).and_return(generator)

          @generator.leave_project(@project)
        end

        it "run target dependency generator on root node" do
          generator = double("Target Dependency Generator").as_null_object
          expect(@project).to receive(:accept).with(generator)
          allow(TargetDependency).to receive(:new).and_return(generator)

          @generator.leave_project(@project)
        end

        it "run scheme generator on root node" do
          generator = double("Scheme Generator").as_null_object
          expect(@project).to receive(:accept).with(generator)
          allow(Scheme).to receive(:new).and_return(generator)

          @generator.leave_project(@project)
        end

        it "should save project" do
          expect(@project).to receive(:save)
          @generator.leave_project(@project)
        end
      end

      it "run target generator when visiting target" do
        target_generator = double("Target Generator")
        allow(Target).to receive(:new).and_return(target_generator)

        target = double("Target")
        expect(target).to receive(:accept).with(target_generator)

        @generator.visit_target(target)
      end

      it "run configuration generator when visiting configuration" do
        configuration_generator = double("Configuration Generator")
        allow(Configuration).to receive(:new).and_return(configuration_generator)

        configuration = double("Configuration")
        expect(configuration).to receive(:accept).with(configuration_generator)

        @generator.visit_configuration(configuration)
      end
    end
  end
end
