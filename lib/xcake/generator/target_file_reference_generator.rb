require 'pathname'

module Xcake
  # This generator processes the files to add to the project from the
  # `include_files` and `exclude_files`
  #
  class TargetFileReferenceGenerator < Generator
    def initialize(context)
      @context = context
    end

    def self.dependencies
      [TargetGenerator]
    end

    def visit_target(target)
      paths_to_include = Dir.glob(target.include_files).map do |f|
        Pathname.new(f).cleanpath.to_s
      end
      paths_to_exclude = Dir.glob(target.exclude_files).map do |f|
        Pathname.new(f).cleanpath.to_s
      end

      paths = paths_to_include - paths_to_exclude
      paths.each do |p|
        include_file_for_path_and_target(p, target) if PathClassifier.should_include_path?(p)
      end
    end

    private

    def include_file_for_path_and_target(path, target)
      return if File.directory?(path)

      file_reference = @context.file_reference_for_path(path)
      native_target = @context.native_object_for(target)

      build_phase_symbol = PathClassifier.classification_for_path(path)

      if PathClassifier.should_create_build_phase_for_classification?(build_phase_symbol)
        build_phase_class = Xcodeproj::Project::Object.const_get(build_phase_symbol)
        build_phase = native_target.build_phase_by_class(build_phase_class)
        build_phase.add_file_reference(file_reference)
      end
    end
  end
end
