module Xcake
  # This build phase generator detects
  # files and adds them to the copy resources phase.
  #
  # Note: This installer is always the last to be executed.
  class CopyResourcesFileReferenceInstaller < FileReferenceInstaller

    def self.dependencies
      FileReferenceInstaller.repository.select do |i|
        i != self
      end
    end

    def self.can_install_node(node)
      !File.directory?(node.path)
    end

    def add_file_reference_to_target(file_reference, target)
      target.resources_build_phase.add_file_reference(file_reference)
    end
  end
end
