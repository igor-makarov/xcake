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
          target.product_name = t.name
          target.product_type = Xcodeproj::Constants::PRODUCT_TYPE_UTI[t.type]
          target.build_configuration_list = project.new(Xcodeproj::Project::Object::XCConfigurationList)

          product_group = project.products_group
          product = product_group.new_product_ref_for_target(target.product_name, target.product_type)
          target.product_reference = product

          Dir.glob(t.include_files).each do |file|
            root_node.create_children_with_path(file, target)
          end if t.include_files

          Dir.glob(t.exclude_files).each do |file|
            root_node.remove_children_with_path(file, target)
          end if t.exclude_files

          project.debug_build_configurations.each do |b|
            target.debug_build_configuration(b.name)
          end

          project.release_build_configurations.each do |b|
            target.release_build_configuration(b.name)
          end

          generator = BuildConfiguration.new(project, t, target)
          generator.build

          target.add_system_framework(t.system_frameworks)

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
