require 'spec_helper'

module Xcake
  describe LinkBuildPhase do
    before :each do
      @phase = LinkBuildPhase.new
    end
    
    it 'should use correct build phase type' do
      expect(@phase.build_phase_type).to eq(Xcodeproj::Project::Object::PBXFrameworksBuildPhase)
    end

    it 'should initialize list of files with empty array' do
      expect(@phase.files).to eq([])
    end
    
    context 'when adding file' do

      before :each do
        @file = 'Linked.framework'
        @native_build_phase = double('Native Build Phase')
        @context = double('Context')

        allow(@native_build_phase).to receive(:name=)

        @phase.files = [
          @file
        ]
      end

      it 'should add file reference' do
        expect(@context).to receive(:file_reference_for_path).with(@file)
        allow(@native_build_phase).to receive(:add_file_reference)

        @phase.configure_native_build_phase(@native_build_phase, @context)
      end

      it 'should add file reference to build phase' do
        file_reference = double('File Reference')
        
        allow(@context).to receive(:file_reference_for_path).and_return(file_reference)
        expect(@native_build_phase).to receive(:add_file_reference).with(file_reference)

        @phase.configure_native_build_phase(@native_build_phase, @context)
      end
    end
  end
end
