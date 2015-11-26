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

      # def create_schemes_for_application(target)
      #   target.build_configurations.each do |c|
      #     scheme = Scheme.new
      #
      #     scheme.name = "#{target.name}-#{c.name}"
      #     scheme.add_build_target(target)
      #     @xcschememanagement['SuppressBuildableAutocreation'][target.uuid] = {"primary" => true}
      #
      #     unit_test_target = unit_test_target_for_target(target)
      #
      #     if unit_test_target then
      #       scheme.add_test_target(unit_test_target)
      #       unit_test_target.add_dependency(target)
      #       @xcschememanagement['SuppressBuildableAutocreation'][unit_test_target.uuid] = {"primary" => true}
      #     end
      #
      #     schemes << scheme
      #   end
      # end

      # def unit_test_target_for_target(target)
      #   project.targets.find do |t|
      #     t.name = "#{target.name}Tests"
      #   end
      # end

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
