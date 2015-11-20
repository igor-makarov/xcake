module Xcake
  module Generator
    class BuildPhase
      module Registry

        def self.build_phase_generators
          [
              CompileSourceBuildPhase,
              CopyResourcesBuildPhase,
              HeaderFileBuildPhase
          ]
        end

        def self.generator_for_node(node)
          generator_class = self.build_phase_generators.find do |g|
            g.can_install_node(node)
          end
        end
      end
    end
  end
end
