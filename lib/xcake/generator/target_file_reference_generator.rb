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

      # TODO: Add Method to normalize these so they always have "."
      paths_to_include = Dir.glob(target.include_files)
      paths_to_exclude = Dir.glob(target.exclude_files)

      paths = paths_to_include - paths_to_exclude
      paths = reduce_to_classifiable_paths(paths)

      paths.each do |path|
        @context.file_reference_for_path(path)
      end
    end

    def reduce_to_classifiable_paths(paths)
      paths.keep_if do |p|
        PathClassifier.should_include_path(p)
      end
    end
  end
end
