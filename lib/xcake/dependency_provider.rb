require 'tsort'

module Xcake
  class DependencyProvider

    include TSort

    alias_method :tsort_each_node, :each_dependency

    def initialize(dependency_class)

      # Code for searching for dependencies
      #
      dependency_class.fetch_plugins
    end
  end
end
