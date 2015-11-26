require 'spec_helper'

module Xcake
  module Xcode
    describe SchemeList do

      before :each do
        @project = double()
        @scheme_list = SchemeList.new(@project)
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

        target = double()

        allow(@project).to receive(:targets).and_return([target])
        expect(@scheme_list).to receive(:create_schemes_for_target).with(target)

        @scheme_list.recreate_schemes
      end

      it "should create scheme for application" do

        target = double()
        
        allow(target).to receive(:product_type).and_return(Xcodeproj::Constants::PRODUCT_TYPE_UTI[:application])
        expect(@scheme_list).to receive(:create_schemes_for_application).with(target)

        @scheme_list.create_schemes_for_target(target)
      end
    end
  end
end
