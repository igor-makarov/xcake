require 'xcodeproj'

module Xcake
  module Generator
    class Target

      attr_accessor :cakefile
      attr_accessor :project
      attr_accessor :root_node

      def initialize(cakefile, project)
        self.cakefile = cakefile
        self.project = project
        self.root_node = Node.new
      end

      def build
        cakefile.targets.each do |t|

          target = project.new(Xcodeproj::Project::Object::PBXNativeTarget)
          target.name = t.name
          target.product_name = name
          target.product_type = Xcodeproj::Constants::PRODUCT_TYPE_UTI[t.type]

          Dir.glob(t.include_files).each do |file|
            root_node.create_children_with_path(file, target)
          end if t.include_files

          Dir.glob(t.exclude_files).each do |file|
            root_node.remove_children_with_path(file, target)
          end if t.exclude_files

          project.targets << target
        end

        root_node.traverse do |n|
          installer = NodeInstaller.new(project.main_group)
          installer.install(n)
        end
      end
    end
  end
end
