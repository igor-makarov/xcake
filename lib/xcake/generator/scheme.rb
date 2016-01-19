require 'xcodeproj'

module Xcake
  module Generator
    class Scheme

      include Visitor

      attr_accessor :context

      def initialize(context)
        @context = context
      end

      def visit_target(target)
        @context.project.scheme_list.create_schemes_for_target(t)
      end
    end
  end
end
