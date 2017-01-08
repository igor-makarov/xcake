require 'spec_helper'

module Xcake
  describe Scheme do
    before :each do
      @name = 'Scheme'
      @scheme = Scheme.new(@name)
    end

    it 'should set name when initialize' do
      expect(@scheme.name).to eq(@name)
    end

    it 'should set launch configuration to Debug' do
      expect(@scheme.launch_configuration).to eq('Debug')
    end

    it 'should set profile configuration to Debug' do
      expect(@scheme.profile_configuration).to eq('Debug')
    end

    it 'should set analyze configuration to Debug' do
      expect(@scheme.analyze_configuration).to eq('Debug')
    end

    it 'should set archive configuration to Release' do
      expect(@scheme.archive_configuration).to eq('Release')
    end
  end
end
