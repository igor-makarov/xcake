require 'spec_helper'

module Xcake
  describe LinkLibraryFileReferenceInstaller do
    before :each do
      @node = double('Node')
    end

    it 'should not able to install folder' do
      folder_path = 'Folder/'

      allow(@node).to receive(:path).and_return(folder_path)
      allow(File).to receive(:directory?).with(folder_path).and_return(true)

      expect(LinkLibraryFileReferenceInstaller.can_install_node(@node)).to be(false)
    end

    it 'should be able to install dynamic library' do
      allow(@node).to receive(:path).and_return('Library.dylib')
      expect(LinkLibraryFileReferenceInstaller.can_install_node(@node)).to be(true)
    end

    it 'should be able to install static library' do
      allow(@node).to receive(:path).and_return('Library.a')
      expect(LinkLibraryFileReferenceInstaller.can_install_node(@node)).to be(true)
    end

    it 'should be able to install shared object library' do
      allow(@node).to receive(:path).and_return('Library.so')
      expect(LinkLibraryFileReferenceInstaller.can_install_node(@node)).to be(true)
    end

    it 'should be able to install framework' do
      framework_path = 'Library.framework'

      allow(@node).to receive(:path).and_return(framework_path)
      allow(File).to receive(:directory?).with(framework_path).and_return(true)
      expect(LinkLibraryFileReferenceInstaller.can_install_node(@node)).to be(true)
    end
  end
end
