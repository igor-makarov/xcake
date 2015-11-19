require 'spec_helper'

module Xcake
  describe ProjectStructureResolver do

    before :each do
      @cakefile = Cakefile.new

      @resolver = ProjectStructureResolver.new
      @resolver.visit_cakefile(@cakefile)
    end

    context "when resolving cakefile with no configiuarations" do
      
      it "should create a default debug configuration" do
        expect(@cakefile.debug_build_configurations.count).to be(1)
      end

      it "should create a default release configuration" do
        expect(@cakefile.release_build_configurations.count).to be(1)
      end
    end

    #
    # def visit_target(target)
    #
    #   puts "Resolving target #{target.name}..."
    #
    #   @cakefile.debug_build_configurations.each do |b|
    #     target.debug_build_configuration(b.name)
    #   end
    #
    #   @cakefile.release_build_configurations.each do |b|
    #     target.release_build_configuration(b.name)
    #   end
    # end
  end
end
