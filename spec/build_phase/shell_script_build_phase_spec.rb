require 'spec_helper'

module Xcake
  describe ShellScriptBuildPhase do
    
    before :each do
      @phase = ShellScriptBuildPhase.new
    end
    
    it 'should has correct build phase type' do
      expect(@phase.build_phase_type).to eq(Xcodeproj::Project::Object::PBXFrameworksBuildPhase)
    end

    it 'should set script' do
      native_target = double('Native Target')
      script = <<-SCRIPT
        echo hello world
      SCRIPT

      @phase.script = script

      allow(native_target).to receive(:name=)
      expect(native_target).to receive(:shell_script=).with(script.strip_heredoc)

      @phase.configure_native_build_phase(native_target, nil)
    end
  end
end
