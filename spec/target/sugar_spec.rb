require "spec_helper"

module Xcake
  describe Target do
    before :each do
      @target = Target.new
    end

    context "when adding a shell script build phase with a string" do
      before :each do
        @target.shell_script_build_phase("Hello World", <<-SCRIPT)
          echo hello world
        SCRIPT
      end

      it "should add the build phase" do
        expect(@target.build_phases.length).to eq(1)
      end
    end
  end
end
