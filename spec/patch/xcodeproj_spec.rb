require 'spec_helper'

module Xcodeproj
  describe Project do

    it "should set the root object when setup" do
      project = Xcodeproj::Project.new(".", true)
      project.setup_for_xcake

      expect(project.root_object).to_not be(nil)
    end
  end
end
