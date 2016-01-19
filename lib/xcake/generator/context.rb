require 'xcodeproj'

#TODO: Document and Spec
module Xcake
  module Generator
    class Context

      # @return [Project] project for the current generator context
      #
      attr_accessor :project

      # Document
      #
      def new_configuration
        return project.new(Xcodeproj::Project::Object::XCBuildConfiguration)
      end
    end
  end
end
