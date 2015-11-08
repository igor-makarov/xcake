module Xcake
  module Generator
    class Scheme
      attr_accessor :target
      attr_accessor :project
      attr_accessor :root_node

      def initialize(target, project)
        self.target = target
        self.project = project
      end

      def build

      end
    end
  end
end
