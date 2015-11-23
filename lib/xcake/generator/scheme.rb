require 'xcodeproj'

module Xcake
  module Generator
    class Scheme

      include Visitor

#TODO: BDD these are stored
      def initialize(project, target)
        @project = project
        @target = target
      end

      def visit_buildconfiguration(configuration)
      end

      def leave_buildconfiguration(configuration)
      end
    end
  end
end
