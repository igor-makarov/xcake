require "tsort"

module Xcake
  class DependencyProvider

    include TSort

    alias_method :each, :tsort_each_node

    def initialize(dependency_class)
      plugins = dependency_class.load_plugins

      @dependency_graph = plugins.map do |p|
        [p, p.dependencies]
      end.to_h

    end

    def tsort_each_node(&block)
      @dependency_graph.each_key(&block)
    end

    def tsort_each_child(node, &block)
      @dependency_graph[node].each(&block)
    end
  end
end
