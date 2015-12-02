module Xcake
  module Generator
    class BuildPhase
      # This namespace contains methods
      # for working with Build Phase generators.
      #
      module Registry

        # This returns all the build phase generators
        # the order of these is important so that files
        # are added correctly.
        #
        # @return [Array<BuildPhase>] the build phase generators
        #
        def self.build_phase_generators
          [
              CompileSourceBuildPhase,
              HeaderFileBuildPhase,
              CopyXCAssetsBuildPhase,
              CopyResourcesBuildPhase
          ]
        end

        # This returns a build phase generator
        # designed to handle the node
        #
        # @param [Node] node for the build phase generator
        #
        # @return [BuildPhase] the build phase generator
        #
        def self.generator_for_node(node)
          generator_class = self.build_phase_generators.find do |g|
            g.can_install_node(node)
          end
        end
      end
    end
  end
end
