require 'xcodeproj'

module Xcake
  module Generator
    class File
      class Node

        attr_accessor :component
        attr_accessor :parent
        attr_accessor :children
        attr_accessor :targets

        def initialize
          self.children = []
          self.targets = []
        end

        def normalize_components(components)
          components.keep_if do |i|
            i != "."
          end
        end

        def create_child(component)

          node = children.find do |n|
            n.component == component
          end

          if node == nil

            node = Node.new
            node.component = component
            node.parent = self

            children << node
          end

          node
        end

        def create_children_with_path(components, target)
          components = normalize_components(components)

          child = create_child(components.shift)
          child.create_children_with_path(components, target) if components.count > 0

          targets << target unless targets.include? target
        end

        def traverse(path=".", &block)
          children.each do |c|
            node_path = "#{path}/#{c.component}"
            block.call(c, node_path) if block_given?
            c.traverse(node_path, &block)
          end
        end
      end
    end
  end
end
