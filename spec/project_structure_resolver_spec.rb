require 'spec_helper'

module Xcake
  describe ProjectStructureResolver do

    before :each do
      @project = Project.new
      @target = Target.new

      @resolver = ProjectStructureResolver.new
      @resolver.visit_project(@project)
      @resolver.visit_target(@target)
    end

    context "when resolving project with no configiuarations" do

      it "should create a default debug configuration" do
        expect(@project.debug_configurations.count).to be(1)
      end

      it "should create a default release configuration" do
        expect(@project.release_configurations.count).to be(1)
      end

      it "should store project" do
        expect(@resolver.project).to be(@project)
      end
    end

    context "when resolving target" do

      it "should propogate debug configurations" do
        expect(@target.debug_configurations.count).to be(1)
      end

      it "should propogate release configurations" do
        expect(@target.release_configurations.count).to be(1)
      end
    end
  end
end
