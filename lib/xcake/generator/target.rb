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
      end

      def leave_target(target)
      end

      def visit_buildconfiguration(configuration)
        generator = BuildConfiguration.new(project, target)
        generator.visit(configuration)
      end

      def leave_buildconfiguration(configuration)
      end
    end
  end
end
