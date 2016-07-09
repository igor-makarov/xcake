require 'spec_helper'

module Xcake
  describe XCDataModeldPathClassifier do
    before :each do
      @node = double('Node').as_null_object
    end

    it 'should not able to install folder' do
      folder_path = 'Folder/'

      allow(@node).to receive(:path).and_return(folder_path)
      allow(File).to receive(:directory?).with(folder_path).and_return(true)

      expect(XCDataModeldPathClassifier.can_install_node(@node)).to be(false)
    end

    it 'should be able to install xcdatamodeld foler' do
      folder_path = 'Model.xcdatamodeld'

      allow(@node).to receive(:path).and_return(folder_path)
      allow(File).to receive(:directory?).with(folder_path).and_return(true)

      expect(XCDataModeldPathClassifier.can_install_node(@node)).to be(true)
    end

    it 'should ignore child paths' do
      expect(XCDataModeldPathClassifier.ignore_child_paths).to eq(true)
    end
  end
end