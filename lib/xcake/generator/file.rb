require 'xcodeproj'

module Xcake
  module Generator
    class File

      attr_accessor :cakefile
      attr_accessor :project
      attr_accessor :root_node

      def initialize(cakefile, project)
        self.cakefile = cakefile
        self.project = project
        self.root_node = Node.new
      end

      def add_files(pattern, target)
        files = Dir.glob(pattern)

        files.each do |file|
          root_node.create_children_with_path(file, target)
        end
      end

      def remove_files(pattern, target)
        files = Dir.glob(pattern)

        files.each do |file|
          root_node.remove_children_with_path(file, target)
        end
      end

      def build
        main_group = project.main_group
        root_node.install(main_group)
      end
    end
  end
end
