require 'xcodeproj'

module Xcake
  module Generator
    class File
      class Node

        attr_accessor :component
        attr_accessor :path
        attr_accessor :parent
        attr_accessor :children
        attr_accessor :targets

        def initialize
          self.children = []
          self.targets = []
        end

        def [](component)
          children.find do |c|
            c.component == component
          end
        end

        def normalize_components(components)
          components.keep_if do |i|
            i != "."
          end
        end

        def create_child(component)

          node = self[component]

          if node == nil

            node = Node.new
            node.component = component
            node.parent = self

#TODO: Move into method and test
            if self.path
              node.path = "#{self.path}/#{component}"
            else
              node.path = component
            end

            children << node
          end

          node
        end

        def create_children_with_path(components, target)
          components = normalize_components(components)

          child = create_child(components.shift)
          child.targets << target unless child.targets.include? target
          child.create_children_with_path(components, target) if components.count > 0
        end

        def remove_children_with_path(components, target)
          components = normalize_components(components)

          child = self[components.shift]
          child.targets.delete(target) if components.count == 0
          child.remove_children_with_path(components, target) if components.count > 0

          targets.delete(target) unless children.any? do |c|
            c.targets.include? target
          end

          children.delete(child) unless child.targets.count > 0
        end

        def traverse(&block)
          children.each do |c|
            block.call(c) if block_given?
            c.traverse(&block)
          end
        end
      end
    end
  end
end
