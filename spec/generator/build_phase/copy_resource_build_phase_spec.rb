require 'spec_helper'

module Xcake
  module Generator
    describe CopyResourcesBuildPhase do

      before :each do
        @node = double()
      end

      it "should not able to install folder" do
        folder_path = 'Folder/'

        allow(@node).to receive(:path).and_return(folder_path)
        allow(File).to receive(:directory?).with(folder_path).and_return(true)

        expect(CopyResourcesBuildPhase.can_install_node(@node)).to be(false)
      end

      it "should be able to install non source code file" do
        allow(@node).to receive(:path).and_return('File.txt')
        expect(CopyResourcesBuildPhase.can_install_node(@node)).to be(true)
      end

      it "should add file reference to copy resources build phase" do

        file_reference = double()

        resources_build_phase = double()
        expect(resources_build_phase).to receive(:add_file_reference).with(file_reference)

        target = double()
        allow(target).to receive(:resources_build_phase).and_return(resources_build_phase)

        generator = CopyResourcesBuildPhase.new(nil)
        generator.add_file_reference_to_target(file_reference, target)
      end
    end
  end
end
