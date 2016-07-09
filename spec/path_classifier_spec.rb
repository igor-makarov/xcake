require 'spec_helper'

module Xcake
  describe PathClassifier do
    context 'when created' do
      it 'should include files' do
        should_install = PathClassifier.should_include_path('./File.txt')
        expect(should_install).to be(true)
      end

      it 'should include folders' do
        should_install = PathClassifier.should_include_path('./Folder')
        expect(should_install).to be(true)
      end

      it 'should not include folders for localization' do
        should_install = PathClassifier.should_include_path('./Folder.lproj')
        expect(should_install).to be(false)
      end

      it 'should include localized files' do
        should_install = PathClassifier.should_include_path('./Folder.lproj/File.txt')
        expect(should_install).to be(true)
      end

      it 'should not include files inside of a classified container' do
        should_install = PathClassifier.should_include_path('./Folder.framework/File.txt')
        expect(should_install).to be(false)
      end
    end
  end
end
