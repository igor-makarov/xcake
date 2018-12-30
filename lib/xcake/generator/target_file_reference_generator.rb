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

    ## This method will return an array of files based on the passed regular Exp
    ## NOTE:- directories will not be included in the array
    def get_cleaned_paths(reg_exp)
      paths_without_directories = Dir.glob(reg_exp).reject do |f|
        file_ext = File.extname(f)
        disallowed_extensions = [
          '.xcdatamodeld',
          '.xcassets',
          '.framework',
          '.bundle'
        ]

        File.directory?(f) && !disallowed_extensions.include?(file_ext)
      end
      paths = paths_without_directories.map do |f|
        Pathname.new(f).cleanpath.to_s
      end
      paths
    end

    def visit_target(target)
      paths_to_include = get_cleaned_paths(target.include_files)
      paths_to_exclude = get_cleaned_paths(target.exclude_files)

      paths = paths_to_include - paths_to_exclude
      paths.each do |p|
        include_file_for_path_and_target(p, target) if PathClassifier.should_include_path?(p)
      end
    end

    private

    def include_file_for_path_and_target(path, target)
      file_reference = @context.file_reference_for_path(path)
      native_target = @context.native_object_for(target)

      build_phase_symbol = PathClassifier.classification_for_path(path)

      return unless PathClassifier.should_create_build_phase_for_classification?(build_phase_symbol)
      return if target.info_plist_paths.include?(path)

      build_phase_class = Xcodeproj::Project::Object.const_get(build_phase_symbol)
      build_phase = native_target.build_phase_by_class(build_phase_class)
      build_phase.add_file_reference(file_reference)
    end
  end
end
