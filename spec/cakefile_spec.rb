require 'spec_helper'

module Xcake
  describe Cakefile do

    it "should have a default project name" do
      cakefile = Cakefile.new

      expect(cakefile.project_name).to eq("Project")
    end

    it "should set project name" do
      cakefile = Cakefile.new("Test")

      expect(cakefile.project_name).to eq("Test")
    end

    it "should initialize targets" do
      cakefile = Cakefile.new

      expect(cakefile.targets).not_to be(nil)
    end

    it "should store targets when created" do
      cakefile = Cakefile.new do |c|
        c.target
      end

      expect(cakefile.targets.count).to eq(1)
    end

    context "when creating application" do
      before :each do
        @cakefile = Cakefile.new do |c|
          @target = c.application_for :ios, 8.0
        end
      end

      it "should store targets when created" do
        expect(@cakefile.targets.count).to eq(1)
      end

      it "should store set type to application" do
        expect(@target.type).to eq(:application)
      end
    end
  end
end
