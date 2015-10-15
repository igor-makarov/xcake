require 'xcodeproj'

module Xcake
  module Generator
    class File

      attr_accessor :cakefile
      attr_accessor :project

      def initialize(cakefile, project)
        self.cakefile = cakefile
        self.project = project
      end

      def add_files(pattern, target)
      end

      def exclude_files(pattern, target)
      end

      def build
      end
    end
  end
end
