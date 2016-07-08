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
      # - References from Configurations
      # - References from Build Phases
      paths_to_include = Dir.glob(target.include_files)
      paths_to_exclude = Dir.glob(target.exclude_files)
      paths = paths_to_include - paths_to_exclude

      paths.each do |path|
        @context.file_reference_for_path(path)
      end

      # - Classify Files
      # - Build Implicit Build Phases
    end
  end
end
