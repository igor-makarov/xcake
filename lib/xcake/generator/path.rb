module Xcake
  module Generator
    class Path

      include Visitor

      attr_accessor :project

      def initialize(project)
        @project = project
      end

      def visit_node(node)

        puts "Adding #{node.path}..."

        generator_class = BuildPhase::Registry.generator_for_node(node)

        if generator_class
          generator = generator_class.new(@project)
          node.accept(generator)
        end
      end

      def leave_node(node)
      end
    end
  end
end
