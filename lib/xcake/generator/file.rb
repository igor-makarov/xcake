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

        files.each do |f|
          components = f.split('/')
          root_node.create_children_with_path(components, target)
        end
      end

      def exclude_files(pattern, target)
        files = Dir.glob(pattern)

        files.each do |f|

        end
      end

      def build
        root_node.traverse do |n|
          if ::File.directory?("./#{n.path}")
            group = project.main_group
            group.find_subpath(n.path, true)
          end
        end
      end
    end
  end
end
