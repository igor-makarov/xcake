require 'spec_helper'

module Xcake
  module Generator
    describe TargetDependency do

      before :each do
        @context = double("Context")
        @generator = TargetDependency.new(@context)
      end

      it "should add native dependency to target" do
        dependency = double("Dependency")

        target = double("Target")
        allow(target).to receive(:target_dependencies).and_return([dependency])

        native_dependency = double("Native Dependency")
        native_target = double("Native Target")

        allow(@context.target_table).to receive(:target_table).and_return({
          dependency: native_dependency,
          target: native_target,
          })
        expect(native_target).to receive(:add_dependency).with(native_dependency)

        @generator.visit_target(target)
      end

      # def visit_target(target)
      #
      #   native_target = context.target_table[target]
      #
      #   target.target_dependancies.each do |dep|
      #
      #     puts "Adding #{dep} as dependency for #{target}..."
      #
      #     native_dependancy = context.target_table[dep]
      #   end
      # end

    end
  end
end
