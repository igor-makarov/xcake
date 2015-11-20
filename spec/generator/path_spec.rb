require 'spec_helper'

module Xcake
  module Generator
    describe Path do

      it "should store the project" do
        project = double()
        generator = Path.new(project)

        expect(generator.project).to be(project)
      end

      it "should ignore node with no path" do
        node = double()
        allow(node).to receive(:path).and_return(nil)

        generator = Path.new(nil)
        generator.visit_node(node)
      end

      #No Path

      #Path - No generator

      #Path - Generator
    end
  end
end
