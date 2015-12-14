require 'spec_helper'

module Xcake
  describe Project do

    before :each do
      @project = Project.new
    end

    context "when creating application target" do
      before :each do
        @target = @project.application_for :ios, 8.0
      end

      it "should store targets when created" do
        expect(@project.targets.count).to eq(1)
      end

      it "should set type to application" do
        expect(@target.type).to eq(:application)
      end

      it "should set platform" do
        expect(@target.platform).to eq(:ios)
      end

      it "should set deployment target" do
        expect(@target.deployment_target).to eq(8.0)
      end

      it "should default to objective c" do
        expect(@target.language).to eq(:objc)
      end

      context "when specifying language" do

        before :each do
          @project = Project.new do |c|
            @target = c.application_for :ios, 8.0, :swift
          end
        end

        it "should set language" do
          expect(@target.language).to eq(:swift)
        end
      end
    end
    context "when creating unit test target" do
      before :each do
        @app_target = double("App Target")

        allow(@app_target).to receive(:name).and_return("application")
        allow(@app_target).to receive(:platform).and_return(:ios)
        allow(@app_target).to receive(:deployment_target).and_return(8.0)
        allow(@app_target).to receive(:language).and_return(:swift)

        @target = @project.unit_tests_for @app_target
      end

      #t.name = "#{host_target.name}Tests"

      it 'should prefix application name with "Tests"'  do
        expect(@target.name).to eq("applicationTests")
      end

      it "should set type to unit test bundle" do
        expect(@target.type).to eq(:unit_test_bundle)
      end

      it "should set platform to same as application target" do
        expect(@target.platform).to eq(:ios)
      end

      it "should set deployment target to same as application target" do
        expect(@target.deployment_target).to eq(8.0)
      end

      it "should set language to same as application target" do
        expect(@target.language).to eq(:swift)
      end

      it "should set test host to application target executable" do
        executable_path = "$(BUILT_PRODUCTS_DIR)/#{@app_target.name}.app/#{@app_target.name}"
        expect(@target.all_configurations.settings["TEST_HOST"]).to eq(executable_path)
      end

      it "should set bundle loader setting to test host" do
        expect(@target.all_configurations.settings["BUNDLE_LOADER"]).to eq("$(TEST_HOST)")
      end
    end

    context "when creating watch target" do
      before :each do
        @target = @project.application_for :ios, 8.0
      end
    end
  end
end
