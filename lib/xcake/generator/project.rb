require 'xcodeproj'

module Xcake
  module Generator
    class Project

      attr_accessor :cakefile

      def initialize(cakefile)

        self.cakefile = cakefile
      end

      def build

        project = Xcodeproj::Project.new "./#{self.cakefile.project_name}.xcodeproj"
        project.save
        puts "Build :)"
      end
    end
  end
end
