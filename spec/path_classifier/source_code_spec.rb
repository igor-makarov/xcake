require 'spec_helper'

module Xcake
  describe SourceCodePathClassifier do
    before :each do
      @node = double('Node')
    end

    it 'should not able to install folder' do
      allow(@node).to receive(:path).and_return('Folder/')
      expect(SourceCodePathClassifier.can_install_node(@node)).to be(false)
    end

    it 'should not able to install non source code file' do
      allow(@node).to receive(:path).and_return('File.txt')
      expect(SourceCodePathClassifier.can_install_node(@node)).to be(false)
    end

    it 'should be able to install c source code file' do
      allow(@node).to receive(:path).and_return('File.c')
      expect(SourceCodePathClassifier.can_install_node(@node)).to be(true)
    end

    it 'should be able to install objective-c source code file' do
      allow(@node).to receive(:path).and_return('File.m')
      expect(SourceCodePathClassifier.can_install_node(@node)).to be(true)
    end

    it 'should be able to install objective-c++ source code file' do
      allow(@node).to receive(:path).and_return('File.mm')
      expect(SourceCodePathClassifier.can_install_node(@node)).to be(true)
    end

    it 'should be able to install c++ source code file' do
      allow(@node).to receive(:path).and_return('File.cpp')
      expect(SourceCodePathClassifier.can_install_node(@node)).to be(true)
    end

    it 'should be able to install swift source code file' do
      allow(@node).to receive(:path).and_return('File.swift')
      expect(SourceCodePathClassifier.can_install_node(@node)).to be(true)
    end
  end
end
