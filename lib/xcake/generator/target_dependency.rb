require 'xcodeproj'

module Xcake
  module Generator
    class TargetDependency

      attr_accessor :context

      def initialize(context)
        @context = context
      end
    end
  end
end
