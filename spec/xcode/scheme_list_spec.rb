require 'spec_helper'

module Xcake
  module Xcode
    describe SchemeList do
      before :each do
        @project = double('Project').as_null_object
        @scheme_list = SchemeList.new(@project)
        @writing_path = '.'

        @target = double('Target').as_null_object
        allow(@target).to receive(:name).and_return('app')
        allow(@target).to receive(:product_type).and_return(Xcodeproj::Constants::PRODUCT_TYPE_UTI[:application])

        allow(@project).to receive(:path).and_return(@writing_path)
        allow(@project).to receive(:targets).and_return([@target])
        allow(@project).to receive(:find_unit_test_target_for_target).and_return(nil)
        allow(@project).to receive(:find_ui_test_target_for_target).and_return(nil)
      end

      it 'should store project' do
        expect(@scheme_list.project).to be(@project)
      end

      it 'should create empty schemes array' do
        expect(@scheme_list.schemes).to eq([])
      end

      it 'should create default scheme management hash' do
        expect(@scheme_list.xcschememanagement).to eq('SchemeUserState' => {},
                                                      'SuppressBuildableAutocreation' => {})
      end

      context 'when supressing target scheme autocreation' do
        it 'should store entry in xcschememanagement' do
          @scheme_list.supress_autocreation_of_target(@target)
          autocreation_setting = @scheme_list.xcschememanagement['SuppressBuildableAutocreation'][@target.uuid]['primary']
          expect(autocreation_setting).to eq(true)
        end
      end

      context 'when saving' do
        it 'should make schemes directory' do
          schemes_dir = Scheme.user_data_dir(@writing_path)

          allow(@scheme_list).to receive(:write_plist)
          expect(FileUtils).to receive(:mkdir_p).with(schemes_dir)

          @scheme_list.save
        end

        context 'schemes' do
          before :each do
            @scheme = double('Scheme').as_null_object
            allow(@scheme_list).to receive(:schemes).and_return([@scheme])
          end

          it 'should save scheme' do
            allow(@project).to receive(:path).and_return(@writing_path)
            expect(@scheme).to receive(:save_as).with(@project.path, @scheme.name, true)
            @scheme_list.save
          end

          it 'should add scheme to scheme managment list' do
            @scheme_list.save
            scheme_entry = @scheme_list.xcschememanagement['SchemeUserState']["#{@scheme.name}.xcscheme_^#shared#^_"]

            expect(scheme_entry).to eq('isShown' => true)
          end
        end

        context 'scheme management list' do
          it 'should be saved' do
            expected_path = Scheme.user_data_dir(@writing_path) + 'xcschememanagement.plist'
            expect(@scheme_list).to receive(:write_plist).with(expected_path)

            @scheme_list.save
          end
        end

        context 'when writing plist' do
          it 'it should use legacy method for older Xcodeproj' do
            allow(Xcake).to receive(:modern_xcodeproj?).and_return(false)
            expect(Xcodeproj).to receive(:write_plist).with(@scheme_list.xcschememanagement, @writing_path)

            @scheme_list.write_plist(@writing_path)
          end

          it 'it should use modern method for current Xcodeproj' do
            allow(Xcake).to receive(:modern_xcodeproj?).and_return(true)
            expect(Xcodeproj::Plist).to receive(:write_to_path).with(@scheme_list.xcschememanagement, @writing_path)

            @scheme_list.write_plist(@writing_path)
          end
        end
      end
    end
  end
end
