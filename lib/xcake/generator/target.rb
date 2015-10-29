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

      def configure_target(target, platform, deployment_target)
        puts platform
        puts deployment_target

        # TODO: Figure out how to pull this off
        #
        # target.build_configuration_list = configuration_list(project, platform, deployment_target, type, language)
        #
        # # Product
        # product = product_group.new_product_ref_for_target(name, type)
        # target.product_reference = product
        #
        # # Build phases
        # target.build_phases << project.new(PBXSourcesBuildPhase)
        # target.build_phases << project.new(PBXFrameworksBuildPhase)
        #
        # # Frameworks
        # framework_name = (platform == :osx) ? 'Cocoa' : 'Foundation'
        # target.add_system_framework(framework_name)

      end

      def build
        cakefile.targets.each do |t|

#TODO: Refactor this.

          target = project.new(Xcodeproj::Project::Object::PBXNativeTarget)
          target.name = t.name
          target.product_name = t.name
          target.product_type = Xcodeproj::Constants::PRODUCT_TYPE_UTI[t.type]

          configure_target(target, t.platform, t.deployment_target)

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
