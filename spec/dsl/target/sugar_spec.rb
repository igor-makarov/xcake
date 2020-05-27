require 'spec_helper'

module Xcake
  describe Target do
    before :each do
      @project = Project.new
      @target = Target.new(@project)
      @build_phase_name = 'Hello World'
    end

    context 'when adding a copy headers build phase with a string' do
      before :each do
        @phase = @target.headers_build_phase
      end

      it 'should add the build phase' do
        expect(@target.build_phases.length).to eq(1)
      end
    end

    context 'when adding a shell script build phase with a string' do
      before :each do
        @script = <<-SCRIPT
          echo hello world
        SCRIPT

        @phase = @target.shell_script_build_phase(@build_phase_name, @script)
      end

      it 'should set the name' do
        expect(@phase.name).to eq(@build_phase_name)
      end

      it 'should set the script' do
        expect(@phase.script).to eq(@script)
      end

      it 'should add the build phase' do
        expect(@target.build_phases.length).to eq(1)
      end
    end
  end
end
