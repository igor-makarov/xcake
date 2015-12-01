require 'spec_helper'

module Xcake
  module Xcode
    describe SchemeList do

      before :each do
        @project = double("Project").as_null_object
        @scheme_list = SchemeList.new(@project)

        @target = double("Target").as_null_object
        allow(@target).to receive(:name).and_return("app")
        allow(@target).to receive(:product_type).and_return(Xcodeproj::Constants::PRODUCT_TYPE_UTI[:application])

        allow(@project).to receive(:targets).and_return([@target])
      end

      it "should store project" do
        expect(@scheme_list.project).to be(@project)
      end

      it "should create empty schemes array" do
        expect(@scheme_list.schemes).to eq([])
      end

      it "should create default scheme management hash" do
        expect(@scheme_list.xcschememanagement).to eq({
          'SchemeUserState' => {},
          'SuppressBuildableAutocreation' => {}
        })
      end

      it "should create schemes for each target" do
        expect(@scheme_list).to receive(:create_schemes_for_target).with(@target)
        @scheme_list.recreate_schemes
      end

      it "should create scheme for application" do
        expect(@scheme_list).to receive(:create_schemes_for_application).with(@target)
        @scheme_list.create_schemes_for_target(@target)
      end

      context "when creating scheme for application" do

        before :each do
          @build_configuration = double("Build Configuration").as_null_object
          allow(@target).to receive(:build_configurations).and_return([@build_configuration])

          @scheme = double("Scheme").as_null_object
          allow(Scheme).to receive(:new).and_return(@scheme)
        end

        it "should set correct name" do
          allow(@build_configuration).to receive(:name).and_return("debug")
          expect(@scheme).to receive(:name=).with("#{@target.name}-#{@build_configuration.name}")
          @scheme_list.create_schemes_for_application(@target)
        end

        it "should add build target" do
          expect(@scheme).to receive(:add_build_target).with(@target)
          @scheme_list.create_schemes_for_application(@target)
        end

        it "should suppress target scheme autocreation" do
          @scheme_list.create_schemes_for_application(@target)
          autocreation_setting = @scheme_list.xcschememanagement['SuppressBuildableAutocreation'][@target.uuid]['primary']
          expect(autocreation_setting).to eq(true)
        end

        it "should store scheme" do
          @scheme_list.create_schemes_for_application(@target)
          expect(@scheme_list.schemes.count).to eq(1)
        end

        context "and adding unit test" do

          before :each do
            @unit_test_target = double("Unit Test Target").as_null_object
            allow(@project).to receive(:find_unit_test_target_for_target).and_return(@unit_test_target)
          end

          it "should add test target" do
            expect(@scheme).to receive(:add_test_target).with(@unit_test_target)
            @scheme_list.create_schemes_for_application(@target)
          end

          it "add target as depedancy for unit test target" do
            expect(@unit_test_target).to receive(:add_dependency).with(@target)
            @scheme_list.create_schemes_for_application(@target)
          end

          it "should suppress unit test target scheme autocreation" do
            @scheme_list.create_schemes_for_application(@target)
            autocreation_setting = @scheme_list.xcschememanagement['SuppressBuildableAutocreation'][@unit_test_target.uuid]['primary']
            expect(autocreation_setting).to eq(true)
          end
        end
      end

      context "when saving" do

        it "should make schemes directory" do
          schemes_dir = Scheme.user_data_dir(".")

          allow(Xcodeproj).to receive(:write_plist)
          expect(FileUtils).to receive(:mkdir_p).with(schemes_dir)

          @scheme_list.save(".")
        end

        context "schemes" do

          before :each do
            @scheme = double("Scheme").as_null_object
            allow(@scheme_list).to receive(:schemes).and_return([@scheme])
          end

          it "should save scheme" do
            expect(@scheme).to receive(:save_as).with(@project.path, @scheme.name, true)
            @scheme_list.save(".")
          end

          it "should add scheme to scheme managment list" do
            @scheme_list.save(".")
            scheme_entry = @scheme_list.xcschememanagement['SchemeUserState']["#{@scheme.name}.xcscheme_^#shared#^_"]

            expect(scheme_entry).to eq({
              "isShown" => true
            })
          end
        end

        context "scheme management list" do

          it "should be saved" do
            xcschememanagement_path = Scheme.user_data_dir(".") + 'xcschememanagement.plist'
            expect(Xcodeproj).to receive(:write_plist).with(@scheme_list.xcschememanagement, xcschememanagement_path)

            @scheme_list.save(".")
          end
        end
      end
    end
  end
end
