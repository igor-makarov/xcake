module Xcake
  class HeaderFileReferenceInstaller < PathClassifier
    # This build phase generator detects header files
    # and ignores them.
    #
    def self.can_install_node(node)
      !File.directory?(node.path) &&
        %w(.h .hpp).include?(File.extname(node.path))
    end
  end
end
