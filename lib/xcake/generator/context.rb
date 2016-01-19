require 'xcodeproj'

module Xcake
  module Generator
    # This class provides the context for the generators
    # and provides information like the current xcode project
    # and mappings from the DSL Targets to the Xcode targets. 
    #
    class Context

      # @return [Project] project for the current generator context
      #
      attr_accessor :project

      # @return [Project] project for the current generator context
      #
      attr_accessor :target_table

      def initialize
        self.target_table = {}
      end

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
