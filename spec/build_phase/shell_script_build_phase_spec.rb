require 'spec_helper'

module Xcake
  describe ShellScriptBuildPhase do
    before :each do
      @script = <<-SCRIPT
          echo hello world
      SCRIPT

      @phase = ShellScriptBuildPhase.new
      @phase.name = 'Name'
      @phase.script = @script

      @native_build_phase = double('Native Build Phase')

      allow(@native_build_phase).to receive(:name=)
      allow(@native_build_phase).to receive(:shell_script=)
    end

    it 'should use correct build phase type' do
      expect(@phase.build_phase_type).to eq(Xcodeproj::Project::Object::PBXFrameworksBuildPhase)
    end

    it 'should set name when configuring native build phase' do
      expect(@native_build_phase).to receive(:name=).with(@phase.name)
      @phase.configure_native_build_phase(@native_build_phase, nil)
    end

    it 'should set script' do
      expect(@native_build_phase).to receive(:shell_script=).with(@script.strip_heredoc)
      @phase.configure_native_build_phase(@native_build_phase, nil)
    end
  end
end
