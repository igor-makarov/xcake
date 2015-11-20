require 'spec_helper'

module Xcake
  module Generator
    describe CopyResourcesBuildPhase do

      it "should not able to install folder" do
        folder_path = 'Folder/'

        node = double()
        allow(node).to receive(:path) { folder_path }
        allow(File).to receive(:directory?).with(folder_path).and_return(true)

        expect(CopyResourcesBuildPhase.can_install_node(node)).to be(false)
      end

      it "should be able to install non source code file" do
        node = double()
        allow(node).to receive(:path) { 'File.txt' }

        expect(CopyResourcesBuildPhase.can_install_node(node)).to be(true)
      end

      it "should not be able to install c header file" do
        node = double()
        allow(node).to receive(:path) { 'File.h' }

        expect(CopyResourcesBuildPhase.can_install_node(node)).to be(false)
      end

      it "shouldnot be able to install c++ header file" do
        node = double()
        allow(node).to receive(:path) { 'File.hpp' }

        expect(CopyResourcesBuildPhase.can_install_node(node)).to be(false)
      end
      #
      # it "should add file reference to copy resources build phase" do
      #
      #   node = double()
      #
      #   resources_build_phase = double()
      #   expect(resources_build_phase).to receive(:add_node).with(node)
      #
      #   target = double()
      #   allow(target).to receive(:resources_build_phase).and_return(resources_build_phase)
      #
      #   generator = CopyResourcesBuildPhase.new(node)
      #   generator.visit_target(target)
      # end
    end
  end
end
