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
        node = Node.new

        cakefile.targets.each do |t|

          target = project.new(Xcodeproj::Project::Object::PBXNativeTarget)
          target.name = t.name

          Dir.glob(t.include_files).each do |file|
            node.create_children_with_path(file, target)
          end if t.include_files

          Dir.glob(t.exclude_files).each do |file|
            node.remove_children_with_path(file, target)
          end if t.exclude_files

          project.targets << target
        end

        main_group = project.main_group
        node.traverse do |n|
          if n.type == Node::Type::DIRECTORY
            main_group.find_subpath(n.path, true)
          else
            group = main_group.find_subpath(n.parent.path, true)
            file = group.new_reference(n.path)

            n.targets.each do |t|
              t.resources_build_phase.add_file_reference(file)
            end
          end
        end
      end
    end
  end
end
