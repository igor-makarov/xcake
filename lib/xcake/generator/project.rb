require 'xcodeproj'

module Xcake
  module Generator
    class Project

      attr_accessor :cakefile

      def initialize(cakefile)
        self.cakefile = cakefile
      end

      def output_filepath
        "./#{self.cakefile.project_name}.xcodeproj"
      end

      def build
        project = Xcode::Project.new(output_filepath, true)
        project.setup_for_xcake
        project.save
      end
    end
  end
end
