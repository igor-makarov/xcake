module Xcake
  module Generator
    class BuildPhase

      attr_accessor :file_reference

      def self.can_install_file_reference(file_reference)
        true
      end

      def self.can_install_node(node)
        true
      end

      def initialize(file_reference)
        @file_reference = file_reference
      end

      def visit_target(target)
      end
    end
  end
end
