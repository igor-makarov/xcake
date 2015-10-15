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
        files = Dir.glob(pattern)

        files.each do |f|
          puts f
        end
      end

      def exclude_files(pattern, target)
        files = Dir.glob(pattern)
      end

      def build
      end
    end
  end
end
