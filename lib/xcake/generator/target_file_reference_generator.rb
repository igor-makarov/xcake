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

      paths_to_include = Dir.glob(target.include_files).map { |f|
        Pathname.new(f).cleanpath.to_s
      }
      paths_to_exclude = Dir.glob(target.exclude_files).map { |f|
        Pathname.new(f).cleanpath.to_s
      }

      paths = paths_to_include - paths_to_exclude

      paths.each do |p|
        @context.file_reference_for_path(p) if PathClassifier.should_include_path(p)
      end
    end
  end
end
