require 'xcodeproj'

module Xcake
  module Generator
    describe Scheme do

      before :each do
        @project = double("Project")
        @context = double("Context").as_null_object
        @generator = Scheme.new(@context)

        @target = double("Target").as_null_object

        allow(@target).to receive(:name).and_return("app")
        allow(@target).to receive(:testing_target).and_return(nil)
        allow(@target).to receive(:product_type).and_return(Xcodeproj::Constants::PRODUCT_TYPE_UTI[:application])

        allow(@project).to receive(:targets).and_return([@target])
      end

      it "should store context" do
        expect(@generator.context).to be(@context)
      end

      it "should create empty schemes array" do
        expect(@generator.schemes).to eq([])
      end

      it "should create default scheme management hash" do
        expect(@generator.xcschememanagement).to eq({
          'SchemeUserState' => {},
          'SuppressBuildableAutocreation' => {}
        })
      end

      it "should create scheme for application" do
        expect(@generator).to receive(:create_schemes_for_application).with(@target)
        @generator.visit_target(@target)
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
          @generator.create_schemes_for_application(@target)
        end

        it "should configure with build target" do
          expect(@scheme).to receive(:configure_with_targets).with(@target, nil)
          @generator.create_schemes_for_application(@target)
        end

        it "should suppress target scheme autocreation" do
          @generator.create_schemes_for_application(@target)
          autocreation_setting = @generator.xcschememanagement['SuppressBuildableAutocreation'][@target.uuid]['primary']
          expect(autocreation_setting).to eq(true)
        end

        it "should store scheme" do
          @generator.create_schemes_for_application(@target)
          expect(@generator.schemes.count).to eq(1)
        end

        context "and adding unit test" do

          before :each do
            @unit_test_target = double("Unit Test Target").as_null_object

            allow(@target).to receive(:testing_target).and_return(@unit_test_target)
          end

          it "should configure with test target" do
            expect(@scheme).to receive(:configure_with_targets).with(@target, @unit_test_target)
            @generator.create_schemes_for_application(@target)
          end

          it "should suppress unit test target scheme autocreation" do
            @generator.create_schemes_for_application(@target)
            autocreation_setting = @generator.xcschememanagement['SuppressBuildableAutocreation'][@unit_test_target.uuid]['primary']
            expect(autocreation_setting).to eq(true)
          end
        end
      end

      context "when saving" do

        it "should make schemes directory" do
          schemes_dir = Xcode::Scheme.user_data_dir(".")

          allow(Xcodeproj).to receive(:write_plist)
          expect(FileUtils).to receive(:mkdir_p).with(schemes_dir)

          @generator.leave_project(@project)
        end

        context "schemes" do

          before :each do
            @scheme = double("Scheme").as_null_object
            allow(@generator).to receive(:schemes).and_return([@scheme])
          end

          it "should save scheme" do
            expect(@scheme).to receive(:save_as).with(@project.path, @scheme.name, true)
            @generator.leave_project(@project)
          end

          it "should add scheme to scheme managment list" do
            @generator.leave_project(@project)
            scheme_entry = @generator.xcschememanagement['SchemeUserState']["#{@scheme.name}.xcscheme_^#shared#^_"]

            expect(scheme_entry).to eq({
              "isShown" => true
            })
          end
        end

        context "scheme management list" do

          it "should be saved" do
            xcschememanagement_path = Xcode::Scheme.user_data_dir(".") + 'xcschememanagement.plist'
            expect(Xcodeproj).to receive(:write_plist).with(@generator.xcschememanagement, xcschememanagement_path)

            @generator.leave_project(@project)
          end
        end
      end
    end
  end
end
