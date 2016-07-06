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
      native_group = @context.native_object_for(node)


      file_reference = native_group[node.component] ||
                       native_group.new_reference(node.component)

      ######

      node.targets.each do |t|
        add_file_reference_to_target(file_reference, t)
      end
    end
  end
end
