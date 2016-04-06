module Xcake
  # This build phase generator detects
  # files and adds them to the copy resources phase.
  #
  class CopyResourcesFileReferenceInstaller < FileReferenceInstaller

    def self.dependencies
      FileReferenceInstaller.repository.select do |i|
        i != self
      end
    end

    def self.can_install_node(node)
      extension = File.extname(node.path)
      (!File.directory?(node.path) ||
        (File.directory?(node.path) &&
            ![".xcassets", ".xcdatamodeld", ".lproj"].include?(extension) &&
            node.children.count == 0))
    end

    def add_file_reference_to_target(file_reference, target)
      target.resources_build_phase.add_file_reference(file_reference)
    end
  end
end
