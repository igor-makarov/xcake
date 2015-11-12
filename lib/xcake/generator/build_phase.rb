module Xcake
  module Generator
    class BuildPhase

      def self.can_install_file_reference(file_reference)
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
