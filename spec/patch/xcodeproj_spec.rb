require 'spec_helper'

module Xcodeproj
  describe Project do

    it "should set the root object when setup" do
      project = Xcodeproj::Project.new(".", true)
      project.setup_for_xcake

      expect(project.root_object).to_not be(nil)
    end

    it "should return archive version as last known" do
      project = Xcodeproj::Project.new(".", true)

      expect(project.archive_version).to eq(Constants::LAST_KNOWN_ARCHIVE_VERSION)
    end

    it "should return pbject version as default" do
      project = Xcodeproj::Project.new(".", true)

      expect(project.object_version).to eq(Constants::DEFAULT_OBJECT_VERSION)
    end
  end
end
