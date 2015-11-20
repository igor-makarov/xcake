require 'spec_helper'

module Xcake
  module Generator
    describe BuildPhase do

      it "should be able to install node" do
        node = double()
        expect(BuildPhase.can_install_node(node)).to be(true)
      end

      it "should store the project" do
        project = double()
        build_phase = BuildPhase.new(project)

        expect(build_phase.project).to eq(project)
      end
    end
  end
end
