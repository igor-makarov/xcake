require 'spec_helper'

module Xcodeproj
  class Project
    module Object
      describe PBXNativeTarget do
        before :each do
          @project = double('Project').as_null_object
        end

        it 'should be library target type when framework' do
          target = PBXNativeTarget.new(@project, nil)
          target.product_type = Constants::PRODUCT_TYPE_UTI[:framework]
          expect(target.library_target_type?).to eq(true)
        end

        it 'should be library target type when static library' do
          target = PBXNativeTarget.new(@project, nil)
          target.product_type = Constants::PRODUCT_TYPE_UTI[:static_library]
          expect(target.library_target_type?).to eq(true)
        end

        it 'should be library target type when dynamic library' do
          target = PBXNativeTarget.new(@project, nil)
          target.product_type = Constants::PRODUCT_TYPE_UTI[:dynamic_library]
          expect(target.library_target_type?).to eq(true)
        end
      end
    end
  end
end
