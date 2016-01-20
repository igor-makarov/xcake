require 'spec_helper'

module Xcake
  module Generator
    describe Context do

      before :each do
        @context = Context.new
        @context.project = double("Project").as_null_object
      end

      it "should return a new configuration" do
        configuration = @context.new_configuration
        expect(configuration).not_to be_nil
      end

      it "should initilize target table" do
        expect(@context.target_table).to eq({})
      end

      describe "when creating native target" do

        before :each do
          @target = double('Target')
          @native_target = @context.new_target(@target)
        end

        it "should return a new target" do
          expect(@native_target).not_to be_nil
        end

        it "should store target in target table" do
          expect(@context.target_table[@target]).to eq(@native_target)
        end
      end

    end
  end
end
