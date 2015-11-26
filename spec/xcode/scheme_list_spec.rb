require 'spec_helper'

module Xcake
  module Xcode
    describe SchemeList do

      before :each do
        @project = double().as_null_object
        @scheme_list = SchemeList.new(@project)

        @target = double().as_null_object
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


        #     @xcschememanagement['SuppressBuildableAutocreation'][target.uuid] = {"primary" => true}
        #
        #     unit_test_target = project.find_unit_test_target_for_target(target)
        #
        #     if unit_test_target then
        #       scheme.add_test_target(unit_test_target)
        #       unit_test_target.add_dependency(target)
        #       @xcschememanagement['SuppressBuildableAutocreation'][unit_test_target.uuid] = {"primary" => true}
        #     end
        #
        #     schemes << scheme

        before :each do
          @build_configuration = double().as_null_object
          allow(@target).to receive(:build_configurations).and_return([@build_configuration])

          @scheme = double().as_null_object
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
      end


      # def save(writing_path)
      #
      #   schemes_dir = Scheme.user_data_dir(writing_path)
      #
      #   FileUtils.rm_rf(schemes_dir)
      #   FileUtils.mkdir_p(schemes_dir)
      #
      #   schemes.each do |s|
      #
      #     puts "Saving Scheme #{s.name}..."
      #     s.save_as(@project.path, s.name, true)
      #
      #     @xcschememanagement['SchemeUserState']["#{s.name}.xcscheme_^#shared#^_"] = {}
      #     @xcschememanagement['SchemeUserState']["#{s.name}.xcscheme_^#shared#^_"]['isShown'] = true
      #   end
      #
      #   puts "Saving Scheme List..."
      #
      #   xcschememanagement_path = schemes_dir + 'xcschememanagement.plist'
      #   Xcodeproj.write_plist(@xcschememanagement, xcschememanagement_path)
      # end
    end
  end
end
