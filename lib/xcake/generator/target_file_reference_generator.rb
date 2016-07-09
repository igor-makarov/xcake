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
      paths = reduce_to_classifiable_paths(paths)

      paths.each do |path|
        @context.file_reference_for_path(path)
      end
    end

    def reduce_to_classifiable_paths(paths)

      classifiable_paths = []

      # TODO: Simplify classfication system
      #
      classfiers = DependencyProvider.new(PathClassifier).tsort
      paths.each do |p|
        classifier = classfiers.select do |c|
          c.can_classify_path(p)
        end

        classifiable_paths << p
      end

      classifiable_paths
    end
  end
end
