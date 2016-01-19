require 'xcodeproj'

module Xcake
  module Generator
    class TargetDependency

      include Visitor

      attr_accessor :context

      def initialize(context)
        @context = context
      end

      def visit_project(project)
      end

      def leave_project(project)
      end

      def visit_target(target)

        native_target = context.target_table[target]

        target.target_dependencies.each do |dep|

          puts "Adding #{dep.name} as dependency for #{target.name}..."

          native_dependancy = context.target_table[dep]
          native_target.add_dependency(native_dependancy)
        end
      end

      def leave_target(target)
      end

      def visit_configuration(configuration)
      end

      def leave_configuration(configuration)
      end
    end
  end
end
