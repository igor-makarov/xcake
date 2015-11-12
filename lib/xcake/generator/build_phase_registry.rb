module Xcake
  class FileReferenceInstaller
    module Registry

      def self.build_phase_generators
        [
            CompileSourceBuildPhase,
            CopyResourcesBuildPhase
        ]
      end

      def self.generator_for_file_reference(file_reference)
        generator_class = self.build_phase_generators.find do |g|
          g.can_install_file_reference(file_reference)
        end

        generator = generator_class.new(file_reference)
      end
    end
  end
end
