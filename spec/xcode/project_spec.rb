require 'spec_helper'

module Xcake
  module Xcode
    describe Project do

      it "should set the root object when setup" do
        project = Project.new(".", true)
        project.setup_for_xcake

        expect(project.root_object).to_not be(nil)
      end

      it "should set the configuration list when setup" do
        project = Project.new(".", true)
        project.setup_for_xcake

        expect(project.root_object.build_configuration_list).to_not be(nil)
      end

      it "should return object version as default" do
        project = Project.new(".", true)

        expect(project.object_version).to eq(Xcodeproj::Constants::DEFAULT_OBJECT_VERSION.to_s)
      end
    end
  end
end
