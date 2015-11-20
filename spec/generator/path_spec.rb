require 'spec_helper'

module Xcake
  module Generator
    describe Path do

      before :each do
        @project = double()
      end

      it "should store the project" do
        generator = Path.new(@project)
        expect(generator.project).to be(@project)
      end

      context "when visiting node" do

        before :each do
          @generator = Path.new(nil)
          @node = double().as_null_object
        end

        context "with no path" do

          it "should ignore it" do
            allow(@node).to receive(:path).and_return(nil)
            @generator.visit_node(@node)
          end
        end

        context "with path" do

          context "and no generator class" do

            it "it should ignore it" do
              allow(BuildPhase::Registry).to receive(:generator_for_node).and_return(nil)
              @generator.visit_node(@node)
            end
          end

          context "and generator class" do

            before :each do
              @build_phase = double().as_null_object
              allow(BuildPhase::Registry).to receive(:generator_for_node).and_return(@build_phase)
            end

            it "should initialize generator with project" do
              expect(@build_phase).to receive(:new).with(@project)

              generator = Path.new(@project)
              generator.visit_node(@node)
            end

            it "should accept generator" do
              expect(@node).to receive(:accept).with(@build_phase)

              generator = Path.new(@project)
              generator.visit_node(@node)
            end
          end
        end
      end
    end
  end
end
