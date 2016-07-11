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

    it 'should add included paths' do
      allow(@target).to receive(:include_files).and_return(@paths)
      allow(@target).to receive(:exclude_files).and_return([])

      path = @paths.first

      expect(@context).to receive(:file_reference_for_path).with(path)
      @generator.visit_target(@target)
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
