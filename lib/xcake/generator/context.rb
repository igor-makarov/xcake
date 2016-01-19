require 'xcodeproj'

module Xcake
  module Generator
    class Context

      # @return [Project] project for the current generator context
      #
      attr_accessor :project

      def self.context_for_filepath()
      end
    end
  end
end
