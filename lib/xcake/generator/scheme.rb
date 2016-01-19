require 'xcodeproj'

module Xcake
  module Generator
    class Scheme

      attr_accessor :context

      def initialize(context)
        @context = context
      end
    end
  end
end
