module Xcake
  # This class is used to hold a headers build phase name
  # and script contents
  #
  class HeadersBuildPhase < BuildPhase
    attr_accessor :public
    attr_accessor :private
    attr_accessor :project

    def initialize
      @public = []
      @private = []
      @project = []

      yield(self) if block_given?
    end

    def build_phase_type
      Xcodeproj::Project::Object::PBXHeadersBuildPhase
    end

    def configure_native_build_phase(native_build_phase, context)

      #TODO: Refactor
      #TODO: Add Settings / Attributes to files
      #TODO: Constantfy visibility

      @public.each do |file|
        file_reference = context.file_reference_for_path(file)
        build_file = native_build_phase.add_file_reference(file_reference)
        build_file.settings = { "ATTRIBUTES" => ['Public'] }
      end

      @private.each do |file|
        file_reference = context.file_reference_for_path(file)
        build_file = native_build_phase.add_file_reference(file_reference)
        build_file.settings = { "ATTRIBUTES" => ['Private'] }
      end

      @project.each do |file|
        file_reference = context.file_reference_for_path(file)
        native_build_phase.add_file_reference(file_reference)
      end
    end
  end
end
