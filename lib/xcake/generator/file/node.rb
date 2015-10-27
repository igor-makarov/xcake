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

        def install(main_group)
          if ::File.directory?("./#{n.path}")
#TODO: Handle different types and tweaking so group defaults to select targets in xcode
            main_group.find_subpath(self.path, true)
          else
#TODO: Handle different types (i.e Frameworks and xcassets) and adding to phases for targets
            group = main_group.find_subpath(self.parent.path, true)
            group.new_reference(self.path)
          end

          children.each do |c|
            c.install(main_group)
          end
        end
      end
    end
  end
end
