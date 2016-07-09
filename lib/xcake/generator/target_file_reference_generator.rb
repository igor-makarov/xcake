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

      paths_to_include = Dir.glob(target.include_files)
      paths_to_exclude = Dir.glob(target.exclude_files)
      paths = paths_to_include - paths_to_exclude
      paths = PathClassifier.reduce_to_classifiable_paths(paths)

      paths.each do |path|
        @context.file_reference_for_path(path)
      end
    end
  end
end
