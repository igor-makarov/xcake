require 'spec_helper'

module Xcake
  describe ResourcePathClassifier do
    before :each do
      @node = double('Node')
    end

    it 'should classify folder' do
      folder_path = 'Folder/'
      expect(ResourcePathClassifier.can_classify_path(folder_path)).to \
        be(true)
    end

    it 'should classify file' do
      expect(ResourcePathClassifier.can_classify_path('File.txt')).to \
        be(true)
    end

    it 'should include folder' do
      folder_path = 'Folder/'
      expect(ResourcePathClassifier.should_include_path(folder_path)).to \
        be(true)
    end

    it 'should include file' do
      expect(ResourcePathClassifier.should_include_path('File.txt')).to \
        be(true)
    end
  end
end
