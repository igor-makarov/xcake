module Xcake
  # This build phase generator detects xcconfigs
  # files, adds them to the project and tries to connect them
  # to a configuration.
  #
  # TODO: In future we will implement a 2 phase file installer system.
  class XCConfigFileReferenceInstaller < FileReferenceInstaller
    def self.can_install_node(node)
      !File.directory?(node.path) &&
        %w(.xcconfig).include?(File.extname(node.path))
    end

    def add_file_reference_to_target(file_reference, target)
      # target.frameworks_build_phases.add_file_reference(file_reference, true)
    end
  end
end
