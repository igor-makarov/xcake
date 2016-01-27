require 'xcodeproj'

module Xcake
  module Generator
    class Context
      include Visitable

      attr_accessor :project
      attr_accessor :root_node
      attr_accessor :target_table

    end
  end
end
