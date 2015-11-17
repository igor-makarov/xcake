require 'spec_helper'

module Xcake
  module Generator
    describe CopyResourcesBuildPhase do

      it "should not able to install folder" do
        file_reference = double()
        allow(file_reference).to receive(:path) { 'Folder/' }

        expect(CopyResourcesBuildPhase.can_install_file_reference(file_reference)).to be(false)
      end

      it "should be able to install non source code file" do
        file_reference = double()
        allow(file_reference).to receive(:path) { 'File.txt' }

        expect(CopyResourcesBuildPhase.can_install_file_reference(file_reference)).to be(true)
      end

      it "should not be able to install c header file" do
        file_reference = double()
        allow(file_reference).to receive(:path) { 'File.h' }

        expect(CompileSourceBuildPhase.can_install_file_reference(file_reference)).to be(false)
      end

      it "shouldnot be able to install c++ header file" do
        file_reference = double()
        allow(file_reference).to receive(:path) { 'File.hpp' }

        expect(CompileSourceBuildPhase.can_install_file_reference(file_reference)).to be(false)
      end
      #Test adding file reference
    end
  end
end
