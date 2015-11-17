module Xcake
  module Generator
    class CompileSourceBuildPhase < BuildPhase

      def self.can_install_file_reference(file_reference)
        File.directory?(file_reference.path) == false &&
        [".c", ".m", ".mm", ".cpp", ".swift"].include?(File.extname(file_reference.path))
      end

      def install_for_target(target)
        target.source_build_phase.add_file_reference(@file_reference)
      end
    end
  end
end
