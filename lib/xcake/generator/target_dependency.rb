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
      end

      def leave_target(target)
      end
    end
  end
end
