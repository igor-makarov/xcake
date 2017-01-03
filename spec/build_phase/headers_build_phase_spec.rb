require 'spec_helper'

# build_file.settings = { "ATTRIBUTES" => ['Public'] }
# build_file.settings = { "ATTRIBUTES" => ['Private'] }

module Xcake
  describe HeadersBuildPhase do
    before :each do
      @phase = HeadersBuildPhase.new

      @file = 'Haeder.h'
      @file_reference = double('File Reference')
      @native_build_phase = double('Native Build Phase')
      @context = double('Context')
      @build_file = double('Build File')

      allow(@build_file).to receive(:settings=)
      allow(@native_build_phase).to receive(:name=)
      allow(@native_build_phase).to receive(:add_file_reference).and_return(@build_file)
      allow(@context).to receive(:file_reference_for_path).and_return(@file_reference)
    end

    it 'should use correct build phase type' do
      expect(@phase.build_phase_type).to eq(Xcodeproj::Project::Object::PBXHeadersBuildPhase)
    end

    context 'public headers' do
      it 'should be initialized with empty array' do
        expect(@phase.public).to eq([])
      end

      context 'when added' do
        before :each do
          @phase.public = [
            @file
          ]
        end

        it 'should add file reference' do
          expect(@context).to receive(:file_reference_for_path).with(@file)
          @phase.configure_native_build_phase(@native_build_phase, @context)
        end

        it 'add file reference to build phase' do
          expect(@native_build_phase).to receive(:add_file_reference).with(@file_reference)
          @phase.configure_native_build_phase(@native_build_phase, @context)
        end

        it 'should set build file attribute to public' do
          expect(@build_file).to receive(:settings=).with(PUBLIC_HEADER_ATTRIBUTE)
          @phase.configure_native_build_phase(@native_build_phase, @context)
        end
      end
    end

    context 'private headers' do
      it 'should be initialized with empty array' do
        expect(@phase.private).to eq([])
      end

      context 'when added' do
        before :each do
          @phase.private = [
            @file
          ]
        end

        it 'should add file reference' do
          expect(@context).to receive(:file_reference_for_path).with(@file)
          @phase.configure_native_build_phase(@native_build_phase, @context)
        end

        it 'should add file reference to build phase' do
          expect(@native_build_phase).to receive(:add_file_reference).with(@file_reference)
          @phase.configure_native_build_phase(@native_build_phase, @context)
        end

        it 'should set build file attribute to private' do
          expect(@build_file).to receive(:settings=).with(PRIVATE_HEADER_ATTRIBUTE)
          @phase.configure_native_build_phase(@native_build_phase, @context)
        end
      end
    end

    context 'project headers' do
      it 'should be initialized with empty array' do
        expect(@phase.project).to eq([])
      end

      context 'when added' do
        before :each do
          @phase.project = [
            @file
          ]
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
  end
end
