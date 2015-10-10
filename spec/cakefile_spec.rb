require 'spec_helper'

module Xcake
  describe Cakefile do

    it "should initialize targets" do
      cakefile = Cakefile.new

      expect(cakefile.targets).not_to be(nil)
    end

    it "should store targets when created" do
      cakefile = Cakefile.new do |c|
        c.target "Target"
      end

      expect(cakefile.targets.count).to eq(1)
    end

    it "should set target name when created" do

      name = "Target"

      cakefile = Cakefile.new do |c|
        c.target name
      end

      expect(cakefile.targets.first.name).to eq(name)
    end
  end
end
