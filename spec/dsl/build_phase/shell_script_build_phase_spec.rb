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

      @paths = %w(path1 path2 path3 path4 path5).shuffle

      allow(@native_build_phase).to receive(:input_paths=)
      allow(@native_build_phase).to receive(:output_paths=)
      allow(@native_build_phase).to receive(:input_file_list_paths=)
      allow(@native_build_phase).to receive(:output_file_list_paths=)
    end

    it 'should use correct build phase type' do
      expect(@phase.build_phase_type).to eq(Xcodeproj::Project::Object::PBXShellScriptBuildPhase)
    end

    it 'should set name when configuring native build phase' do
      expect(@native_build_phase).to receive(:name=).with(@phase.name)
      @phase.configure_native_build_phase(@native_build_phase, nil)
    end

    it 'should set script' do
      expect(@native_build_phase).to receive(:shell_script=).with(@script.strip_heredoc)
      @phase.configure_native_build_phase(@native_build_phase, nil)
    end

    context 'Input/Ouput paths' do
      it 'should set input paths' do
        @phase.input_paths = @paths
        expect(@native_build_phase).to receive(:input_paths=).with(@paths)
        @phase.configure_native_build_phase(@native_build_phase, nil)
      end

      it 'should set output paths' do
        @phase.output_paths = @paths
        expect(@native_build_phase).to receive(:output_paths=).with(@paths)
        @phase.configure_native_build_phase(@native_build_phase, nil)
      end

      it 'should set input file list paths' do
        @phase.input_file_list_paths = @paths
        expect(@native_build_phase).to receive(:input_file_list_paths=).with(@paths)
        @phase.configure_native_build_phase(@native_build_phase, nil)
      end

      it 'should set output file list paths' do
        @phase.output_file_list_paths = @paths
        expect(@native_build_phase).to receive(:output_file_list_paths=).with(@paths)
        @phase.configure_native_build_phase(@native_build_phase, nil)
      end
    end
  end
end
