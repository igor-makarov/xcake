require 'spec_helper'

module Xcake
  describe Context do
    before :each do
      @context = Object.new
      @context.extend(Context)
    end

    it 'should create a object hash' do
      expect(@context.object_hash).not_to be_nil
    end
  end
end
