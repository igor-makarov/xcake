module Xcake
  # This class is used to represent a copy files build phase
  #
  class CopyFilesBuildPhase < BuildPhase
    # The name of the build phase as shown in Xcode
    attr_accessor :name

    # The name of files to copy
    attr_accessor :files

    def build_phase_type
      Xcodeproj::Project::Object::PBXCopyFilesBuildPhase
    end

    def configure_native_build_phase(native_build_phase, context)
      native_build_phase.name = name

      @files.each do |file|
        file_reference = context.file_reference_for_path(file)
        native_build_phase.add_file_reference(file_reference)
      end
    end

    def to_s
      "BuildPhase<#{name}>"
    end
  end
end
