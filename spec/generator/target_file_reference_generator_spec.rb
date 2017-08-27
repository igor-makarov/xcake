require 'spec_helper'

module Xcake
  describe TargetFileReferenceGenerator do
    before :each do
      @context = double('Context')
      @target = double('Target')
      @native_target = double('Native Target').as_null_object

      @generator = TargetFileReferenceGenerator.new(@context)

      @paths = [
        'File'
      ]

      allow(Dir).to receive(:glob).with([]).and_return([])
      allow(Dir).to receive(:glob).with(@paths).and_return(@paths)
      allow(@context).to receive(:native_object_for).with(@target).and_return(@native_target)
    end

    context 'when adding files' do
      before :each do
        allow(@target).to receive(:include_files).and_return(@paths)
        allow(@target).to receive(:exclude_files).and_return([])
      end

      it 'should add them to the project' do
        path = @paths.first

        expect(@context).to receive(:file_reference_for_path).with(path)
        @generator.visit_target(@target)
      end

      it 'should add them to the build phase' do
        build_phase = double('Build Phase')
        allow(@native_target).to receive(:build_phase_by_class).and_return(build_phase)

        path = @paths.first
        file_reference = double('File Reference')
        allow(@context).to receive(:file_reference_for_path).with(path).and_return(file_reference)

        expect(build_phase).to receive(:add_file_reference).with(file_reference)
        @generator.visit_target(@target)
      end
    end

    it 'should ignore excluded paths' do
      allow(@target).to receive(:include_files).and_return(@paths)
      allow(@target).to receive(:exclude_files).and_return(@paths)

      path = @paths.first
      expect(@context).to_not receive(:file_reference_for_path).with(path)
      @generator.visit_target(@target)
    end

    it 'should ignore paths with different root specifier' do
      exclude_paths = [
        './File'
      ]

      allow(@target).to receive(:include_files).and_return(@paths)
      allow(@target).to receive(:exclude_files).and_return(exclude_paths)
      allow(Dir).to receive(:glob).with(exclude_paths).and_return(exclude_paths)

      path = @paths.first
      expect(@context).to_not receive(:file_reference_for_path).with(path)
      @generator.visit_target(@target)
    end

    it "should ingore directories" do
      dir_name = "my.test"
      file1 = "#{dir_name}/File1"
      file2 = "#{dir_name}/File2"
      include_paths = [
        dir_name,
        file1,
        file2
      ]
      allow(@target).to receive(:include_files).and_return(include_paths)
      allow(@target).to receive(:exclude_files).and_return([])
      allow(Dir).to receive(:glob).with(include_paths).and_return(include_paths)
      allow(Dir).to receive(:glob).with([]).and_return([])
      allow(File).to receive(:directory?).and_return(false)
      allow(File).to receive(:directory?).with("my.test").and_return(true)
      allow(@context).to receive(:file_reference_for_path).with(file1)
      allow(@context).to receive(:file_reference_for_path).with(file2)
      expect(@context).to_not receive(:file_reference_for_path).with(dir_name)
      @generator.visit_target(@target)
    end

    it 'should ignore paths which shouldn\'t be installed' do
      exclude_paths = [
        './File'
      ]

      allow(@target).to receive(:include_files).and_return(@paths)
      allow(@target).to receive(:exclude_files).and_return([])
      allow(PathClassifier).to receive(:should_include_path?).and_return(false)

      path = @paths.first
      expect(@context).to_not receive(:file_reference_for_path).with(path)
      @generator.visit_target(@target)
    end
  end
end
