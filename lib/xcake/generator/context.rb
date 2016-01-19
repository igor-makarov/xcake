require 'xcodeproj'

#TODO: Document and Spec
module Xcake
  module Generator
    class Context

      # @return [Project] project for the current generator context
      #
      attr_accessor :project

      # @return [Project] project for the current generator context
      #
      attr_accessor :target_table

      # Creates a new build configuration in the project
      #
      # @return [Configuration] new xcode build configuration
      #
      def new_configuration
        return project.new(Xcodeproj::Project::Object::XCBuildConfiguration)
      end

      # @param [Target] dsl target to create the native xcode target from
      #
      # @return [PBXNativeTarget] new xcode target
      #
      def new_target(target)
        return target_table[target] = project.new_target(target)
      end
    end
  end
end
