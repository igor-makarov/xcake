module Xcake
  # This build phase generator detects
  # files and adds them to the copy resources phase.
  #
  # @note This installer is always the last to be executed.
  #
  class ResourcePathClassifier < PathClassifier
    def self.dependencies
      FileReferenceInstaller.descendants.select do |i|
        i != self
      end
    end

    def self.can_install_node(node)
      extension = File.extname(node.path)
      (!File.directory?(node.path) ||
        (File.directory?(node.path) &&
            !['.xcassets', '.xcdatamodeld', '.lproj'].include?(extension) &&
            node.children.count == 0))
    end

    def add_file_reference_to_target(file_reference, target)
      target.resources_build_phase.add_file_reference(file_reference, true)
    end
  end
end
