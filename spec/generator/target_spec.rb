require 'spec_helper'

module Xcake
  module Generator
    describe Target do

      before :each do
        @project = double()
        @root_node = double()

        @generator = Target.new(@project, @root_node)
      end

      it "should store the project" do
        expect(@generator.project).to eq(@project)
      end

      it "should store the root node" do
        expect(@generator.root_node).to eq(@root_node)
      end

      context 'when visiting a target' do
        it "should create a new target" do
          target = double().as_null_object
          expect(@project).to receive(:new_target).with(target)

          @generator.visit_target(target)
        end
      end

      it 'run build configuration generator when visiting build configuration' do
        build_configuration_generator = double()
        allow(BuildConfiguration).to receive(:new).and_return(build_configuration_generator)

        build_configuration = double()
        expect(build_configuration).to receive(:accept).with(build_configuration_generator)

        @generator.visit_buildconfiguration(build_configuration)
      end
    end
  end
end
