require 'spec_helper'

module Xcake
  module Generator
    describe TargetDependency do

      before :each do
        @context = double("Context").as_null_object
        @generator = TargetDependency.new(@context)
      end

      it "should add native dependency to target" do
        dependency = double("Dependency").as_null_object

        target = double("Target").as_null_object
        allow(target).to receive(:target_dependencies).and_return([dependency])

        native_dependency = double("Native Dependency").as_null_object
        native_target = double("Native Target").as_null_object

        allow(@context).to receive(:target_table).and_return({
          dependency => native_dependency,
          target => native_target,
          })
        expect(native_target).to receive(:add_dependency).with(native_dependency)

        @generator.visit_target(target)
      end
    end
  end
end
