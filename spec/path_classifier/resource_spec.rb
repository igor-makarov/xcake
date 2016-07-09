require 'spec_helper'

module Xcake
  describe ResourcePathClassifier do
    before :each do
      @node = double('Node')
    end

    it 'should be able to install folder as folder reference' do
      folder_path = 'Folder/'

      allow(@node).to receive(:path).and_return(folder_path)
      allow(@node).to receive(:children).and_return([])
      allow(File).to receive(:directory?).with(folder_path).and_return(true)

      expect(ResourcePathClassifier.can_install_node(@node)).to \
        be(true)
    end

    it 'should not able to install xcassets folder' do
      folder_path = 'resources.xcassets/'

      allow(@node).to receive(:path).and_return(folder_path)
      allow(@node).to receive(:children).and_return([])
      allow(File).to receive(:directory?).with(folder_path).and_return(true)

      expect(ResourcePathClassifier.can_install_node(@node)).to \
        be(false)
    end

    it 'should be able to install non source code file' do
      allow(@node).to receive(:path).and_return('File.txt')
      expect(ResourcePathClassifier.can_install_node(@node)).to be(true)
    end
  end
end
