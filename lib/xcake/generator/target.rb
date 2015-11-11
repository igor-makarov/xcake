require 'xcodeproj'

module Xcake
  module Generator
    class Target

      include Visitor

      attr_accessor :project

      def initialize(project)
        self.project = project
      end

      def visit_target(target)

        puts "Creating target #{target.name}..."

        native_target = self.project.new(Xcodeproj::Project::Object::PBXNativeTarget)
        native_target.name = target.name
        native_target.product_name = target.name
        native_target.product_type = Xcodeproj::Constants::PRODUCT_TYPE_UTI[target.type]
        native_target.build_configuration_list = self.project.new(Xcodeproj::Project::Object::XCConfigurationList)

        product_group = self.project.products_group
        product = product_group.new_product_ref_for_target(native_target.product_name, native_target.product_type)
        native_target.product_reference = product

        root_node = Node.new

        Dir.glob(target.include_files).each do |file|
          root_node.create_children_with_path(file, native_target)
        end if target.include_files

        Dir.glob(target.exclude_files).each do |file|
          root_node.remove_children_with_path(file, native_target)
        end if target.exclude_files

        cakefile.debug_build_configurations.each do |b|
          target.debug_build_configuration(b.name)
        end

        cakefile.release_build_configurations.each do |b|
          target.release_build_configuration(b.name)
        end

        generator = BuildConfiguration.new(project, target, native_target)
        generator.build

        native_target.add_system_framework(t.system_frameworks)

        project.targets << native_target

        root_node.traverse do |n|
          installer = NodeInstaller.new(project.main_group)
          installer.install(n)
        end
      end
    end
  end
end
