require 'spec_helper'

module Xcake
  describe Cakefile do

    it "should initialize targets" do
      cakefile = Cakefile.new

      expect(cakefile.targets).not_to be nil
    end

    it "should store targets when created" do
      cakefile = Cakefile.new do |c|
        c.target
      end

      expect(cakefile.targets.count).to eq 1
    end
  end
end
