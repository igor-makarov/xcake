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
puts child.component

          children << child
          targets << target unless targets.include? target
        end
      end
    end
  end
end
