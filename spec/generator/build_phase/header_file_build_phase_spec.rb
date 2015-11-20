require 'spec_helper'

module Xcake
  module Generator
    describe HeaderFileBuildPhase do

      before :each do
        @node = double()
      end

      it "should not able to install folder" do
        folder_path = 'Folder/'

        allow(@node).to receive(:path).and_return(folder_path)
        allow(File).to receive(:directory?).with(folder_path).and_return(true)

        expect(HeaderFileBuildPhase.can_install_node(@node)).to be(false)
      end

      it "should not be able to install non header file" do
        allow(@node).to receive(:path).and_return('File.txt')
        expect(HeaderFileBuildPhase.can_install_node(@node)).to be(false)
      end

      it "should be able to install c header file" do
        allow(@node).to receive(:path).and_return('File.h')
        expect(HeaderFileBuildPhase.can_install_node(@node)).to be(true)
      end

      it "should be able to install c++ header file" do
        allow(@node).to receive(:path).and_return('File.hpp')
        expect(HeaderFileBuildPhase.can_install_node(@node)).to be(true)
      end
    end
  end
end
