require 'xcodeproj'

module Xcake
  module Generator
    class Target

      attr_accessor :cakefile
      attr_accessor :project

      def initialize(cakefile, project)
        self.cakefile = cakefile
        self.project = project
      end

      def build
        cakefile.targets.each do |t|
          target = project.new(Xcodeproj::Project::Object::PBXNativeTarget)
          target.name = t.name
          project.targets << target
        end
      end
    end
  end
end
