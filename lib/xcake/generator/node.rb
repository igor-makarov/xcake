require 'xcodeproj'

#TODO: Refactor this.

module Xcake
  module Generator
    class Node

      module Type
        DIRECTORY = "public.directory"
        SOURCE = "public.source-code"
      end

      attr_accessor :component
      attr_accessor :path
      attr_accessor :parent
      attr_accessor :children
      attr_accessor :targets

      def initialize
        self.children = []
        self.targets = []
      end

      def create_children_with_path(path, target)

        components = path.split('/').keep_if do |c|
          c != "."
        end

        create_children_with_components(components, target)
      end

      def remove_children_with_path(path, target)

        components = path.split('/').keep_if do |c|
          c != "."
        end

        remove_children_with_components(components, target)
      end

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

      def type_tree
        ::CoreFoundation.RubyStringPropertyListRead(`mdls -plist - -name kMDItemContentTypeTree #{self.path}`)["kMDItemContentTypeTree"]
      end

      def traverse(&block)

        yield self if parent

        children.each do |c|
          c.traverse(&block)
        end
      end
    end
  end
end
