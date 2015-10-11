require 'spec_helper'

module Xcake
  describe Cakefile do

    it "should have a default project name" do
      cakefile = Cakefile.new

      expect(cakefile.project_name).to eq("Project")
    end

    it "should initialize build configurations" do
      cakefile = Cakefile.new

      expect(cakefile.build_configurations).not_to be(nil)
    end

    it "should set project name" do
      cakefile = Cakefile.new("Test")

      expect(cakefile.project_name).to eq("Test")
    end

    it "should initialize targets" do
      cakefile = Cakefile.new

      expect(cakefile.targets).not_to be(nil)
    end

    it "should store build configuration when created" do
      cakefile = Cakefile.new do |c|
        c.build_configuration
      end

      expect(cakefile.build_configurations.count).to eq(1)
    end

    it "should store targets when created" do
      cakefile = Cakefile.new do |c|
        c.target "Target"
      end

      expect(cakefile.targets.count).to eq(1)
    end
  end
end
