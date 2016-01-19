require 'xcodeproj'

module Xcake
  module Generator
    class TargetDependency

      include Visitor

      attr_accessor :context

      def initialize(context)
        @context = context
      end

      def visit_target(target)

        native_target = context.target_table[target]

        target.target_dependancies.each do |dep|

          puts "Adding #{dep} as dependency for #{target}..."

          native_dependancy = context.target_table[dep]
          native_target.add_dependency(native_dependancy)
        end
      end

      def leave_target(target)
      end
    end
  end
end
