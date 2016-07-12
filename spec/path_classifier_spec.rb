require 'spec_helper'

module Xcake
  describe PathClassifier do
    context 'when created' do
      it 'should include files' do
        should_install = PathClassifier.should_include_path?('./File.txt')
        expect(should_install).to be(true)
      end

      it 'should include folders' do
        should_install = PathClassifier.should_include_path?('./Folder')
        expect(should_install).to be(true)
      end

      it 'should not include folders for localization' do
        should_install = PathClassifier.should_include_path?('./Folder.lproj')
        expect(should_install).to be(false)
      end

      it 'should include localized files' do
        should_install = PathClassifier.should_include_path?('./Folder.lproj/File.txt')
        expect(should_install).to be(true)
      end

      it 'should not include files inside of a classified container' do
        should_install = PathClassifier.should_include_path?('./Folder.framework/File.txt')
        expect(should_install).to be(false)
      end
    end

    context 'for a framework' do
      it 'should include framework folder' do
        should_install = PathClassifier.should_include_path?('./Folder.framework')
        expect(should_install).to be(true)
      end

      it 'should not include files inside' do
        should_install = PathClassifier.should_include_path?('./Library.framework/Headers/Library.h')
        expect(should_install).to be(false)
      end

      it 'should classify as PBXFrameworksBuildPhase' do
        classification = PathClassifier.classification_for_path('./Library.framework')
        expect(classification).to be(:PBXFrameworksBuildPhase)
      end
    end

    context 'for a dynamic library' do
      it 'should include library file' do
        should_install = PathClassifier.should_include_path?('./Library.dylib')
        expect(should_install).to be(true)
      end

      it 'should classify as PBXFrameworksBuildPhase' do
        classification = PathClassifier.classification_for_path('./Library.dylib')
        expect(classification).to be(:PBXFrameworksBuildPhase)
      end
    end

    context 'for a static library' do
      it 'should include library file' do
        should_install = PathClassifier.should_include_path?('./Library.a')
        expect(should_install).to be(true)
      end

      it 'should classify as PBXFrameworksBuildPhase' do
        classification = PathClassifier.classification_for_path('./Library.a')
        expect(classification).to be(:PBXFrameworksBuildPhase)
      end
    end

    context 'for a shared object file' do
      it 'should include library file' do
        should_install = PathClassifier.should_include_path?('./Library.so')
        expect(should_install).to be(true)
      end

      it 'should classify as PBXFrameworksBuildPhase' do
        classification = PathClassifier.classification_for_path('./Library.so')
        expect(classification).to be(:PBXFrameworksBuildPhase)
      end
    end

    context 'for a C header' do
      it 'should include file' do
        should_install = PathClassifier.should_include_path?('./Header.h')
        expect(should_install).to be(true)
      end

      it 'should classify as PBXHeadersBuildPhase' do
        classification = PathClassifier.classification_for_path('./Header.h')
        expect(classification).to be(:PBXHeadersBuildPhase)
      end
    end

    context 'for a C++ header' do
      it 'should include file' do
        should_install = PathClassifier.should_include_path?('./Header.hpp')
        expect(should_install).to be(true)
      end

      it 'should classify as PBXHeadersBuildPhase' do
        classification = PathClassifier.classification_for_path('./Header.hpp')
        expect(classification).to be(:PBXHeadersBuildPhase)
      end
    end

    context 'for a C file' do
      it 'should include file' do
        should_install = PathClassifier.should_include_path?('./Source.c')
        expect(should_install).to be(true)
      end

      it 'should classify as PBXSourcesBuildPhase' do
        classification = PathClassifier.classification_for_path('./Source.c')
        expect(classification).to be(:PBXSourcesBuildPhase)
      end
    end

    context 'for a C++ file' do
      it 'should include file' do
        should_install = PathClassifier.should_include_path?('./Source.cpp')
        expect(should_install).to be(true)
      end

      it 'should classify as PBXSourcesBuildPhase' do
        classification = PathClassifier.classification_for_path('./Source.cpp')
        expect(classification).to be(:PBXSourcesBuildPhase)
      end
    end

    context 'for a Objective-C file' do
      it 'should include file' do
        should_install = PathClassifier.should_include_path?('./Source.m')
        expect(should_install).to be(true)
      end

      it 'should classify as PBXSourcesBuildPhase' do
        classification = PathClassifier.classification_for_path('./Source.m')
        expect(classification).to be(:PBXSourcesBuildPhase)
      end
    end

    context 'for a Objective-C++ file' do
      it 'should include file' do
        should_install = PathClassifier.should_include_path?('./Source.mm')
        expect(should_install).to be(true)
      end

      it 'should classify as PBXSourcesBuildPhase' do
        classification = PathClassifier.classification_for_path('./Source.mm')
        expect(classification).to be(:PBXSourcesBuildPhase)
      end
    end

    context 'for a Swift file' do
      it 'should include file' do
        should_install = PathClassifier.should_include_path?('./Source.swift')
        expect(should_install).to be(true)
      end

      it 'should classify as PBXSourcesBuildPhase' do
        classification = PathClassifier.classification_for_path('./Source.swift')
        expect(classification).to be(:PBXSourcesBuildPhase)
      end
    end

    context 'for a core data model' do
      it 'should include core data model folder' do
        should_install = PathClassifier.should_include_path?('./Model.xcdatamodeld')
        expect(should_install).to be(true)
      end

      it 'should not include files inside' do
        should_install = PathClassifier.should_include_path?('./Model.xcdatamodeld/Model.xcdatamodel')
        expect(should_install).to be(false)
      end

      it 'should classify as PBXSourcesBuildPhase' do
        classification = PathClassifier.classification_for_path('./Model.xcdatamodeld')
        expect(classification).to be(:PBXSourcesBuildPhase)
      end
    end

    context 'for a xcassets folder' do
      it 'should include xcassets folder' do
        should_install = PathClassifier.should_include_path?('./Assets.xcassets')
        expect(should_install).to be(true)
      end

      it 'should not include files inside' do
        should_install = PathClassifier.should_include_path?('./Assets.xcassets/Image/Image.png')
        expect(should_install).to be(false)
      end

      it 'should classify as PBXResourcesBuildPhase' do
        classification = PathClassifier.classification_for_path('./Assets.xcassets')
        expect(classification).to be(:PBXResourcesBuildPhase)
      end
    end
  end
end
