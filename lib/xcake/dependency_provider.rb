require 'tsort'

module Xcake
  class DependencyProvider

    include TSort

    alias_method :each, :tsort_each_node

    def initialize(dependency_class)

      # Code for searching for dependencies
      #
      dependency_class.fetch_plugins
    end
  end
end
