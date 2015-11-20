require 'spec_helper'

module Xcake
  module Generator
    describe CopyResourcesBuildPhase do

      # it "should not able to install folder" do
      #   folder_path = 'Folder/'
      #
      #   file_reference = double()
      #   allow(file_reference).to receive(:path) { folder_path }
      #   allow(File).to receive(:directory?).with(folder_path).and_return(true)
      #
      #   expect(CopyResourcesBuildPhase.can_install_file_reference(file_reference)).to be(false)
      # end
      #
      # it "should be able to install non source code file" do
      #   file_reference = double()
      #   allow(file_reference).to receive(:path) { 'File.txt' }
      #
      #   expect(CopyResourcesBuildPhase.can_install_file_reference(file_reference)).to be(true)
      # end
      #
      # it "should not be able to install c header file" do
      #   file_reference = double()
      #   allow(file_reference).to receive(:path) { 'File.h' }
      #
      #   expect(CopyResourcesBuildPhase.can_install_file_reference(file_reference)).to be(false)
      # end
      #
      # it "shouldnot be able to install c++ header file" do
      #   file_reference = double()
      #   allow(file_reference).to receive(:path) { 'File.hpp' }
      #
      #   expect(CopyResourcesBuildPhase.can_install_file_reference(file_reference)).to be(false)
      # end
      #
      # it "should add file reference to copy resources build phase" do
      #
      #   file_reference = double()
      #
      #   resources_build_phase = double()
      #   expect(resources_build_phase).to receive(:add_file_reference).with(file_reference)
      #
      #   target = double()
      #   allow(target).to receive(:resources_build_phase).and_return(resources_build_phase)
      #
      #   generator = CopyResourcesBuildPhase.new(file_reference)
      #   generator.visit_target(target)
      # end
    end
  end
end
