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
        @target = @project.unit_tests_for @app_target
      end

      #t.name = "#{host_target.name}Tests"

      it "should set type to unit test bundle" do
        puts "H: #{@app_target}"
        #expect(@target.type).to eq(:unit_test_bundle)
      end

      # t.platform = host_target.platform
      # t.deployment_target = host_target.deployment_target
      # t.language = host_target.language
      #
      # t.all_configurations.settings["TEST_HOST"] = "$(BUILT_PRODUCTS_DIR)/#{host_target.name}.app/#{host_target.name}"
      # t.all_configurations.settings["BUNDLE_LOADER"] = "$(TEST_HOST)"
    end

    context "when creating watch target" do
      before :each do
        @target = @project.application_for :ios, 8.0
      end
    end
  end
end
