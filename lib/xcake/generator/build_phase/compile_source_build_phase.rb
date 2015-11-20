module Xcake
  module Generator
    class CompileSourceBuildPhase < BuildPhase

      def self.can_install_node(node)
        File.directory?(node.path) == false &&
        [".c", ".m", ".mm", ".cpp", ".swift"].include?(File.extname(node.path))
      end

      def add_file_reference_to_target(file_reference, target)
        target.source_build_phase.add_file_reference(file_reference)
      end
    end
  end
end
