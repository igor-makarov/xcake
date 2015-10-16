require 'xcodeproj'

module Xcake
  module Generator
    class File
      class Node

        attr_accessor :component
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

        def create_node_path(components, target)

          components = normalize_components(components)

          child = Node.new

          child.component = components.shift
          child.create_node_path(components, target) if components.count > 0

          children << child
          targets << target unless targets.include? target
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
