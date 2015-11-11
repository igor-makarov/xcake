require 'xcodeproj'

module Xcake
  module Generator
    class Target

      include Visitor

      def initialize(project)
        @project = project
      end

      def visit_target(target)

        puts "Creating target #{target.name}..."

        @native_target = @project.new_target(target)

        #File Node Code
        root_node = Node.new

        Dir.glob(target.include_files).each do |file|
          root_node.create_children_with_path(file, @native_target)
        end if target.include_files

        Dir.glob(target.exclude_files).each do |file|
          root_node.remove_children_with_path(file, @native_target)
        end if target.exclude_files

        root_node.traverse do |n|
          installer = NodeInstaller.new(@project.main_group)
          installer.install(n)
        end

        #Build Configuration Code

      end

      def leave_target(target)
        @native_target.add_system_framework(target.system_frameworks)
      end

      def visit_buildconfiguration(build_configuration)
        #TODO: Crack this
        # generator = BuildConfiguration.new(@project, target, @native_target)
        # build_configuration.accept(generator)
      end

      def leave_buildconfiguration(build_configuration)
      end
    end
  end
end
