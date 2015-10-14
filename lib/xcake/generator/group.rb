require 'xcodeproj'

module Xcake
  module Generator
    class Group

      attr_accessor :cakefile
      attr_accessor :project

      def initialize(cakefile, project)
        self.cakefile = cakefile
        self.project = project
      end

      def build
        self.project.root_object.main_group = project.new(Xcodeproj::Project::Object::PBXGroup)
      end
    end
  end
end
