require "spec_helper"

module Xcake
  describe TargetCustomBuildPhaseGenerator do
    before :each do
      @dsl_target = double("DSL Target")
      @target = double("Target")
      @context = double("Context")
      @generator = TargetCustomBuildPhaseGenerator.new(@context)

      allow(@context).to receive(:native_object_for).and_return(@target)
    end

    it "should have correct dependencies" do
      expect(TargetCustomBuildPhaseGenerator.dependencies).to eq([TargetGenerator])
    end

    it "should generate build phases" do
      build_phase = double("Build Phase").as_null_object

      allow(@dsl_target).to receive(:build_phases).and_return([build_phase])
      expect(build_phase).to receive(:generate_native_build_phase).with(@target)

      @generator.visit_target(@dsl_target)
    end
  end
end
