module Xcake
  module Generator
    # This generator processes the source tree and
    # assigns the base_configuration_reference if
    # a match is found
    #
    class BaseConfig
      include Visitor

      # @return [XCBuildConfiguration] the configuration to modify
      #
      attr_accessor :native_configuration

      # @return [String] the name of the xcconfig file to search for
      #
      attr_accessor :configuration_file

      # @param [XCBuildConfiguration] native_configuration
      #        The build configuration that should be modified
      # @param [String] configuration_file
      #        The name of the file that should be assigned
      #
      def initialize(project, native_configuration, configuration_file)
        @project = project
        @native_configuration = native_configuration
        @configuration_file = configuration_file
      end

      # Find the group which this node
      # should be added to.
      #
      # This dictates where it shows up
      # in the groups structure.
      #
      # @param [Node] the node
      #
      # @return [PBXGroup] the group
      #
      def group_for_node(node)
        return @project.main_group unless node.parent

        @project.main_group.find_subpath(node.parent.path, true)
      end

      protected

      def visit_node(node)
        return unless node.path
        return unless File.basename(node.path) == @configuration_file

        puts "Assigning #{node.path}..."
        group = group_for_node(node)
        file_reference = group.new_reference(node.path)
        @native_configuration.base_configuration_reference = file_reference
      end

      def leave_node(node)
      end
    end
  end
end
