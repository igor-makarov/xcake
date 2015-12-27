require 'spec_helper'

module Xcake
  module Generator
    describe Target do

      before :each do
        @project = double("Project").as_null_object
        @root_node = double("Root Node").as_null_object

        @generator = Target.new(@project, @root_node)
      end

      it "should store the project" do
        expect(@generator.project).to eq(@project)
      end

      it "should store the root node" do
        expect(@generator.root_node).to eq(@root_node)
      end

      context 'when visiting a target' do
        before :each do
          @target = double("Target").as_null_object

          @native_target = double("Native Target")
          allow(@project).to receive(:new_target).and_return(@native_target)
        end

        it "should create a new target" do
          expect(@project).to receive(:new_target).with(@target)
          @generator.visit_target(@target)
        end

        it "should include files" do
          allow(@target).to receive(:include_files).and_return(['**/*.swift'])
          allow(@target).to receive(:exclude_files).and_return(nil)
          allow(Dir).to receive(:glob).and_return(['File.swift'])

          expect(@root_node).to receive(:create_children_with_path).with('File.swift', @native_target)

          @generator.visit_target(@target)
        end

        it "should exclude files" do
          allow(@target).to receive(:include_files).and_return(nil)
          allow(@target).to receive(:exclude_files).and_return(['**/*.swift'])
          allow(Dir).to receive(:glob).and_return(['File.swift'])

          expect(@root_node).to receive(:remove_children_with_path).with('File.swift', @native_target)

          @generator.visit_target(@target)
        end
      end

      it "should add system frameworks" do
        allow(@target).to receive(:system_frameworks).and_return(['Foundation'])
        expect(@native_target).to receive(:add_system_frameworks).with(@target.system_frameworks)

        @generator.native_target = @native_target
        @generator.leave_target(@target)
      end

      it 'run configuration generator when visiting configuration' do
        configuration_generator = double("Configuration Generator")
        allow(Configuration).to receive(:new).and_return(configuration_generator)

        configuration = double("Configuration")
        expect(configuration).to receive(:accept).with(configuration_generator)

        @generator.visit_configuration(configuration)
      end
    end
  end
end
