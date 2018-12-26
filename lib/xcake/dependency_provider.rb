require 'tsort'

module Xcake
  class DependencyProvider
    include TSort

    def initialize(dependency_class)
      plugins = dependency_class.load_plugins

      @dependency_graph = plugins.each_with_object({}) do |p, hash|
        hash[p] = p.dependencies
      end
    end

    def tsort_each_node(&block)
      @dependency_graph.each_key(&block)
    end

    def tsort_each_child(node, &block)
      @dependency_graph[node].each(&block)
    end
  end
end
