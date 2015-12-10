require 'xcodeproj'

module Xcake
  # This class is used to represent a
  # node (File or Directory) in the File System.
  #
  # This tracks which target the node should be
  # added to.
  class Node

    include Visitable

    # @return [String] the component of this node in the path.
    #
    attr_accessor :component

    # @return [String] the path to this node relative to the Cakefile.
    #
    attr_accessor :path

    # @return [String] the parent node.
    #
    attr_accessor :parent

    # @return [Array<Node>] the child nodes.
    #
    attr_accessor :children

    # @return [Array<PBXNativeTarget>] the targets for the node
    #
    attr_accessor :targets

    def initialize
      self.children = []
      self.targets = []
    end

    # Creates child nodes for the path and
    # target.
    #
    # @param [String] path
    #                 path to create children for
    #
    # @param [PBXNativeTarget] target
    #                          target to add for the child nodes
    #
    def create_children_with_path(path, target)

      components = path.split('/').keep_if do |c|
        c != "."
      end

      create_children_with_components(components, target)
    end

    # Removes child nodes for the path and
    # target.
    #
    # @param [String] path
    #                 path to remove children for
    #
    # @param [PBXNativeTarget] target
    #                          target to remove for child nodes
    #
    def remove_children_with_path(path, target)

      components = path.split('/').keep_if do |c|
        c != "."
      end

      remove_children_with_components(components, target)
    end

    protected

    def create_children_with_components(components, target)

      component = components.shift
      child = children.find do |c|
        c.component == component
      end

      if child == nil

        child = Node.new

        child.component = component

        if self.path
          child.path = "#{self.path}/#{component}"
        else
          child.path = "#{component}"
        end

        child.parent = self

        children << child
      end

      child.targets << target unless child.targets.include? target

      child.create_children_with_components(components, target) if components.count > 0

      child
    end

    def remove_children_with_components(components, target)

      component = components.shift

      child = children.find do |c|
        c.component == component
      end

      if child != nil

        child.remove_children_with_components(components, target)

        child.targets.keep_if do |t|
          t != target
        end

        children.keep_if do |c|
          c != child ||
          c.children.count > 0 ||
          c.targets.count > 0
        end
      end
    end

    public

    def accept(visitor)

      visitor.visit(self)

      children.each do |c|
        c.accept(visitor)
      end

      visitor.leave(self)
    end
  end
end
