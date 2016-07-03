module Xcake
  # This build phase generator detects library
  # files and adds them to the frameworks build phase.
  #
  class LinkLibraryFileReferenceInstaller < FileReferenceInstaller
    def self.can_install_node(node)
      %w(.a .dylib .so .framework).include?(File.extname(node.path))
    end

    def add_file_reference_to_target(file_reference, target)
      target.frameworks_build_phases.add_file_reference(file_reference)
    end

    def visit_node(node)
      super

      # Ignore all files inside of libraries
      node.children = []
    end
  end
end
