module Xcake
  # This build phase generator detects source
  # files and adds them to the compile build phase.
  #
  class CompileSourceFileReferenceInstaller < FileReferenceInstaller
    def self.can_install_node(node)
      !File.directory?(node.path) &&
        %w(.c .m .mm .cpp .swift).include?(File.extname(node.path))
    end

    def add_file_reference_to_target(file_reference, target)
      target.source_build_phase.add_file_reference(file_reference, true)
    end
  end
end
