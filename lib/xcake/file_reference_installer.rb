require 'pathname'

module Xcake
  # This generator handles adding nodes
  # to the project and creating a build phase
  # for it.
  #
  class FileReferenceInstaller
    include Dependency
    include Plugin
    include Visitor

    attr_accessor :context

    def initialize(context)
      @context = context
    end

    def self.plugins_location
      "#{File.dirname(__FILE__)}/file_reference_installer/*.rb"
    end

    # This should be overidden
    # by subclasses.
    #
    # @param [Node] the node
    #
    # @return [Boolean] true if build phase can handle the node.
    #
    def self.can_install_node(_node)
      true
    end

    # Adds file reference to the target.
    #
    # This should be overidden in subclasses
    # to add the file reference the correct
    # build phase.
    #
    # @param [PBXFileReference] the file reference
    #
    # @param [PBXTarget] the xcode target
    #
    def add_file_reference_to_target(_file_reference, _target)
    end

    # @!group Visitable

    def visit_node(node)

      # Tweak this to respect localizable files
      #
      # If ".lproj" is in file path
      # - Create variant group from File Component
      # - Files added to this group should have their path to be relative from
      # the first non-variatn group
      #
      # Otherwise normal behaviour
      native_group = @context.native_object_for(node)

      # Make sure this is the correct parent in variant groups
      #
      # TODO: Remove this duplication of the .lproj and node path code.
      # Also remove need for the name hack.
      if node.parent.component.include?(".lproj")
        group_path = Pathname.new node.parent.parent.path
      else
        group_path = Pathname.new node.parent.path
      end

      file_path = Pathname.new node.path

      node_location = file_path.relative_path_from group_path
      file_reference = native_group.new_reference(node_location)

      ######

      node.targets.each do |t|
        add_file_reference_to_target(file_reference, t)
      end
    end
  end
end
