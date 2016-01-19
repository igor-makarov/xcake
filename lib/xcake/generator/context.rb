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

      def new_target(target)
        return project.new_target(target)
      end

      def new_scheme(target)
        return project.scheme_list.create_schemes_for_target(t)
      end
    end
  end
end
