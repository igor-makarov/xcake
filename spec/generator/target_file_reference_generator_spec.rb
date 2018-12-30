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
        allow(@target).to receive(:info_plist_paths).and_return([])
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
      allow(@target).to receive(:info_plist_paths).and_return([])

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

    it 'should ignore directories other than xcdatamodeld and xcassets' do
      dir_name = 'my.test'
      file1 = "#{dir_name}/File1"
      file2 = "#{dir_name}/File2"
      dir2 = "#{dir_name}/My.xcdatamodeld"
      dir3 = "#{dir_name}/My.xcassets"
      file3 = "#{dir2}/My.xcdatamodel"
      file4 = "#{dir3}/My.png"
      include_paths = [
        dir_name,
        file1,
        file2,
        dir2,
        file3,
        dir3,
        file4
      ]
      allow(@target).to receive(:include_files).and_return(include_paths)
      allow(@target).to receive(:exclude_files).and_return([])
      allow(@target).to receive(:info_plist_paths).and_return([])
      allow(Dir).to receive(:glob).with(include_paths).and_return(include_paths)
      allow(Dir).to receive(:glob).with([]).and_return([])
      allow(File).to receive(:directory?).and_return(false)
      allow(File).to receive(:directory?).with(dir_name).and_return(true)
      allow(File).to receive(:directory?).with(dir2).and_return(true)
      allow(File).to receive(:directory?).with(dir3).and_return(true)
      allow(@context).to receive(:file_reference_for_path).with(file1)
      allow(@context).to receive(:file_reference_for_path).with(file2)
      allow(@context).to receive(:file_reference_for_path).with(file3)
      allow(@context).to receive(:file_reference_for_path).with(file4)
      expect(@context).to_not receive(:file_reference_for_path).with(dir_name)
      expect(@context).to receive(:file_reference_for_path).with(dir2)
      expect(@context).to receive(:file_reference_for_path).with(dir3)
      expect(@context).to_not receive(:file_reference_for_path).with(file3)
      expect(@context).to_not receive(:file_reference_for_path).with(file4)
      @generator.visit_target(@target)
    end

    it 'should not add an Info.plist file as a resource if the target uses it as its own' do
      dir_name = 'my.test'
      file1 = "#{dir_name}/File1"
      file2 = "#{dir_name}/File2"
      plist_file = "#{dir_name}/Info.plist"
      include_paths = [
        dir_name,
        file1,
        file2,
        plist_file
      ]
      allow(@target).to receive(:include_files).and_return(include_paths)
      allow(@target).to receive(:exclude_files).and_return([])
      allow(@target).to receive(:info_plist_paths).and_return([plist_file])
      allow(Dir).to receive(:glob).with(include_paths).and_return(include_paths)
      allow(Dir).to receive(:glob).with([]).and_return([])
      allow(File).to receive(:directory?).and_return(false)
      allow(File).to receive(:directory?).with(dir_name).and_return(true)
      allow(@context).to receive(:file_reference_for_path).with(file1)
      allow(@context).to receive(:file_reference_for_path).with(file2)
      expect(@context).to receive(:file_reference_for_path).with(plist_file)
      allow(@context).to receive(:build_phase_by_class).with(file1)
      allow(@context).to receive(:build_phase_by_class).with(file2)
      expect(@context).to_not receive(:build_phase_by_class).with(plist_file)
      @generator.visit_target(@target)
    end

    it 'should ignore paths which shouldn\'t be installed' do
      allow(@target).to receive(:include_files).and_return(@paths)
      allow(@target).to receive(:exclude_files).and_return([])
      allow(PathClassifier).to receive(:should_include_path?).and_return(false)

      path = @paths.first
      expect(@context).to_not receive(:file_reference_for_path).with(path)
      @generator.visit_target(@target)
    end
  end
end
