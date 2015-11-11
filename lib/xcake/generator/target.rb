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
        root_node.create_children_for_target(target)

        root_node.traverse do |n|

          #TODO: Break Node Install into visitors.
          installer = NodeInstaller.new(@project.main_group)
          installer.install(n)
        end

        #Build Configuration Code
        # generator = BuildConfiguration.new(@project, target, @native_target)
        # build_configuration.accept(generator)

        #@native_target.add_system_framework(target.system_frameworks)
      end
    end
  end
end
