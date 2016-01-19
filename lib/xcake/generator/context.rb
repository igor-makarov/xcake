require 'xcodeproj'

#TODO: Document and Spec
module Xcake
  module Generator
    class Context

      # @return [Project] project for the current generator context
      #
      attr_accessor :project

      attr_accessor :target_table

      # Document
      #
      def new_configuration
        return project.new(Xcodeproj::Project::Object::XCBuildConfiguration)
      end

      def new_target(target)
        return target_table[target] = project.new_target(target)
      end
    end
  end
end
