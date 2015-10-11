require 'spec_helper'

module Xcake
  module Xcode
    describe Project do

      it "should set the root object when setup" do
        project = Project.new(".", true)
        project.setup_for_xcake

        expect(project.root_object).to_not be(nil)
      end

      it "should return pbject version as default" do
        project = Project.new(".", true)

        expect(project.object_version).to eq(Constants::DEFAULT_OBJECT_VERSION.to_s)
      end
    end
  end
end
