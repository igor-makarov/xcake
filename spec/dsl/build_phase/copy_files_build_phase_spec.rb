require 'spec_helper'

module Xcake
  describe CopyFilesBuildPhase do
    before :each do
      @phase = CopyFilesBuildPhase.new

      @file = 'FakeFramework.framework'

      @phase.name = 'Name'
      @phase.files = [
          @file
      ]

      @file_reference = double('File Reference')
      @native_build_phase = double('Native Build Phase')
      @context = double('Context')
      @build_file = double('Build File')

      allow(@native_build_phase).to receive(:name=)
      allow(@native_build_phase).to receive(:symbol_dst_subfolder_spec=)
      allow(@native_build_phase).to receive(:dst_path=)
      allow(@native_build_phase).to receive(:add_file_reference).and_return(@build_file)
      allow(@context).to receive(:file_reference_for_path).and_return(@file_reference)
    end

    it 'should use correct build phase type' do
      expect(@phase.build_phase_type).to eq(Xcodeproj::Project::Object::PBXCopyFilesBuildPhase)
    end

    it 'should set name when configuring native build phase' do
      expect(@native_build_phase).to receive(:name=).with(@phase.name)
      @phase.configure_native_build_phase(@native_build_phase, @context)
    end

    it 'should add file reference' do
      expect(@context).to receive(:file_reference_for_path).with(@file)
      @phase.configure_native_build_phase(@native_build_phase, @context)
    end

    it 'add file reference to build phase' do
      expect(@native_build_phase).to receive(:add_file_reference).with(@file_reference)
      @phase.configure_native_build_phase(@native_build_phase, @context)
    end
  end
end
