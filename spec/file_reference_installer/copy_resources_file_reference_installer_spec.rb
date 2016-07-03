require 'spec_helper'

module Xcake
  describe CopyResourcesFileReferenceInstaller do
    before :each do
      @node = double('Node')
    end

    it 'should be able to install folder as folder reference' do
      folder_path = 'Folder/'

      allow(@node).to receive(:path).and_return(folder_path)
      allow(@node).to receive(:children).and_return([])
      allow(File).to receive(:directory?).with(folder_path).and_return(true)

      expect(CopyResourcesFileReferenceInstaller.can_install_node(@node)).to \
        be(true)
    end

    it 'should not able to install xcassets folder' do
      folder_path = 'resources.xcassets/'

      allow(@node).to receive(:path).and_return(folder_path)
      allow(@node).to receive(:children).and_return([])
      allow(File).to receive(:directory?).with(folder_path).and_return(true)

      expect(CopyResourcesFileReferenceInstaller.can_install_node(@node)).to \
        be(false)
    end

    it 'should be able to install non source code file' do
      allow(@node).to receive(:path).and_return('File.txt')
      expect(CopyResourcesFileReferenceInstaller.can_install_node(@node)).to be(true)
    end

    it 'should add file reference to copy resources build phase' do
      file_reference = double('File Reference')

      resources_build_phase = double('Resources Build Pahse')
      expect(resources_build_phase).to receive(:add_file_reference)
        .with(file_reference, true)

      target = double('Target')
      allow(target).to receive(:resources_build_phase).and_return(resources_build_phase)

      generator = CopyResourcesFileReferenceInstaller.new(nil)
      generator.add_file_reference_to_target(file_reference, target)
    end

    # TODO: Test dependencies
  end
end
