require 'spec_helper'

module Xcake
  module Xcode
    describe Project do

      before :each do
        @project = Project.new(".", true)
        @project.setup_for_xcake
      end

      it "should set the root object when setup" do
        expect(@project.root_object).to_not be(nil)
      end

      it "should set the configuration list when setup" do
        expect(@project.root_object.build_configuration_list).to_not be(nil)
      end

      it "should return object version as default" do
        expect(@project.object_version).to eq(Xcodeproj::Constants::DEFAULT_OBJECT_VERSION.to_s)
      end

      it "should have a scheme list" do
        expect(@project.scheme_list).to_not be(nil)
      end

      it "should find unit test target for target" do
        target = double("Target")
        allow(target).to receive(:name).and_return('app')

        unit_test_target = double("Unit Test Target")
        allow(unit_test_target).to receive(:name).and_return('appTests')

        allow(@project).to receive(:targets).and_return([target, unit_test_target])
        found_target = @project.find_unit_test_target_for_target(target)
        expect(found_target).to be(unit_test_target)
      end

      context "when recreating schemes" do

        before :each do
          @scheme_list = double("Scheme List").as_null_object
          allow(@project).to receive(:scheme_list).and_return(@scheme_list)
        end

        it "should tell scheme list to recreate schemes" do
          expect(@scheme_list).to receive(:recreate_schemes)
          @project.recreate_user_schemes
        end

        it "should save scheme list" do
          expect(@scheme_list).to receive(:save).with(@project.path)
          @project.recreate_user_schemes
        end
      end
    end

    #TODO: Test object generation
  end
end
