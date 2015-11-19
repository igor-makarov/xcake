require 'spec_helper'

module Xcake
  describe ProjectStructureResolver do

    before :each do
      @cakefile = Cakefile.new
      @target = Target.new

      @resolver = ProjectStructureResolver.new
      @resolver.visit_cakefile(@cakefile)
      @resolver.visit_target(@target)
    end

    context "when resolving cakefile with no configiuarations" do

      it "should create a default debug configuration" do
        expect(@cakefile.debug_build_configurations.count).to be(1)
      end

      it "should create a default release configuration" do
        expect(@cakefile.release_build_configurations.count).to be(1)
      end

      it "should store cakefile" do
        expect(@resolver.cakefile).to be(@cakefile)
      end
    end

    context "when resolving target" do

      it "should propogate debug configurations" do
        expect(@target.debug_build_configurations.count).to be(1)
      end

      it "should propogate release configurations" do
        expect(@target.release_build_configurations.count).to be(1)
      end
    end


    #   @cakefile.debug_build_configurations.each do |b|
    #     target.debug_build_configuration(b.name)
    #   end
    #
    #   @cakefile.release_build_configurations.each do |b|
    #     target.release_build_configuration(b.name)
    #   end
  end
end
