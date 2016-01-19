module Xcake
  module Generator
    # This generator processes the include and
    # exclude paths, and adds them to the
    # root node to be added to the project.
    #
    class Path

      include Visitor

      # @return [Project] the xcode project
      #
      attr_accessor :context

      # @param [Project] project for the file path
      #
      def initialize(context)
        @context = context
      end

      protected

      def visit_node(node)

        return unless node.path

        puts "Adding #{node.path}..."

        generator_class = BuildPhase::Registry.generator_for_node(node)

        if generator_class
          generator = generator_class.new(@context.project)
          node.accept(generator)
        end
      end

      def leave_node(node)
      end
    end
  end
end
