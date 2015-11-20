require 'spec_helper'

module Xcake
  module Generator
    describe CompileSourceBuildPhase do

      it "should not able to install folder" do
        node = double()
        allow(node).to receive(:path) { 'Folder/' }

        expect(CompileSourceBuildPhase.can_install_node(node)).to be(false)
      end

      it "should not able to install non source code file" do
        node = double()
        allow(node).to receive(:path) { 'File.txt' }

        expect(CompileSourceBuildPhase.can_install_node(node)).to be(false)
      end

      it "should be able to install c source code file" do
        node = double()
        allow(node).to receive(:path) { 'File.c' }

        expect(CompileSourceBuildPhase.can_install_node(node)).to be(true)
      end

      it "should be able to install objective-c source code file" do
        node = double()
        allow(node).to receive(:path) { 'File.m' }

        expect(CompileSourceBuildPhase.can_install_node(node)).to be(true)
      end

      it "should be able to install objective-c++ source code file" do
        node = double()
        allow(node).to receive(:path) { 'File.mm' }

        expect(CompileSourceBuildPhase.can_install_node(node)).to be(true)
      end

      it "should be able to install c++ source code file" do
        node = double()
        allow(node).to receive(:path) { 'File.cpp' }

        expect(CompileSourceBuildPhase.can_install_node(node)).to be(true)
      end

      it "should be able to install swift source code file" do
        node = double()
        allow(node).to receive(:path) { 'File.swift' }

        expect(CompileSourceBuildPhase.can_install_node(node)).to be(true)
      end

      it "should add file reference to source build phase" do

        file_reference = double()

        source_build_phase = double()
        expect(source_build_phase).to receive(:add_file_reference).with(file_reference)

        target = double()
        allow(target).to receive(:source_build_phase).and_return(source_build_phase)

        generator = CompileSourceBuildPhase.new(nil)
        generator.add_file_reference_to_target(file_reference, target)
      end
    end
  end
end
