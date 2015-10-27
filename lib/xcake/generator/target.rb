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

        node.install(project.main_group)
      end
    end
  end
end
