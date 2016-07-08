require 'spec_helper'

# TODO: How do we stub file system
module Xcake
  describe TargetFileReferenceGenerator do
    before :each do
      @context = double('Context')
      @target = double('Target')
      @generator = TargetFileReferenceGenerator.new(@context)

      @paths = [
        "file"
      ]

      allow(Dir).to receive(:glob).with([]).and_return([])
      allow(Dir).to receive(:glob).with(@paths).and_return(@paths)
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
  end
end
