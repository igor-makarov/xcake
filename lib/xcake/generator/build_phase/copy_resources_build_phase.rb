module Xcake
  class CopyResourcesBuildPhase < BuildPhase

    def self.can_install_file_reference(file_reference)
      File.directory?(file_reference.path) == false &&
      [".h", ".hpp"].include?(File.extname(file_reference.path)) == false
    end

    def visit_target(target)
      target.resources_build_phase.add_file_reference(@file_reference)
    end
  end
end
