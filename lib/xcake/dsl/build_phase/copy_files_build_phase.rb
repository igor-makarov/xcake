module Xcake
  # This class is used to represent a copy files build phase
  #
  class CopyFilesBuildPhase < BuildPhase
    # The name of the build phase as shown in Xcode
    attr_accessor :name

    # The name of files to copy
    attr_accessor :files

    # The destination
    attr_accessor :destination

    # The destination path
    attr_accessor :destination_path

    # Whether the files should be code signed on copy
    attr_accessor :code_sign

    def build_phase_type
      Xcodeproj::Project::Object::PBXCopyFilesBuildPhase
    end

    def configure_native_build_phase(native_build_phase, context)
      native_build_phase.name = name
      native_build_phase.dst_path = destination_path
      native_build_phase.symbol_dst_subfolder_spec = destination

      @files.each do |file|
        file_reference = context.file_reference_for_path(file)
        build_file = native_build_phase.add_file_reference(file_reference)
        build_file.settings = { 'ATTRIBUTES' => ['CodeSignOnCopy'] } if code_sign
      end
    end

    def to_s
      "BuildPhase<#{name}>"
    end
  end
end
