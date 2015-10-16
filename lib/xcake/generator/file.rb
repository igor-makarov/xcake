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

        main_group = project.main_group

        root_node.traverse do |n|
          if ::File.directory?("./#{n.path}")
            main_group.find_subpath(n.path, true)
          else
#TODO: Handle different types and adding to phases
            group = main_group.find_subpath(n.parent.path, true)
            group.new_reference(n.path)
          end
        end
      end
    end
  end
end
