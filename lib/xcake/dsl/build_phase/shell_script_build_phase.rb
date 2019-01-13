module Xcake
  # This class is used to represent a shell script build phase
  #
  class ShellScriptBuildPhase < BuildPhase
    # The name of the build phase as shown in Xcode
    attr_accessor :name

    # String coataining the contents of the script to run
    attr_accessor :script

    # input/output paths
    attr_accessor :input_paths
    attr_accessor :output_paths
    attr_accessor :input_file_list_paths
    attr_accessor :output_file_list_paths

    def build_phase_type
      Xcodeproj::Project::Object::PBXShellScriptBuildPhase
    end

    def configure_native_build_phase(native_build_phase, _context)
      native_build_phase.name = name
      native_build_phase.shell_script = script.strip_heredoc
      native_build_phase.input_paths = input_paths || []
      native_build_phase.output_paths = output_paths || []
      native_build_phase.input_file_list_paths = input_file_list_paths || []
      native_build_phase.output_file_list_paths = output_file_list_paths || []
    end

    def to_s
      "BuildPhase<#{name}>"
    end
  end
end
