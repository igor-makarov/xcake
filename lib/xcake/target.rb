module Xcake
  # This class is used to describe a target for a
  # Xcode project; This forms part of the DSL
  # and is usally stored in files named `Cakefile`.
  #
  class Target
    include Configurable
    include Visitable

    # @return [Project] the project for the target.
    #
    attr_accessor :project

    # @return [String] the name of the target.
    #
    attr_accessor :name

    # @return [String] the type of the target.
    #                  Can be `:application`, `:dynamic_library`,
    #                  `framework` or `:static_library`.
    #
    attr_accessor :type

    # @return [String] the platform for the target.
    #                  Can be `:ios`, `:osx`, `:tvos`, `:watchos`.
    #
    attr_accessor :platform

    # @return [String] the minimum deployment version
    #                  for the target's platform.
    #
    attr_accessor :deployment_target

    # @return [String] the language for the target.
    #                  Can be `:objc`, `:swift`.
    #
    attr_accessor :language

    # @return [Array<Xcodeproj::Project::Object::AbstractBuildPhase>] the list
    #                  of custom build phases for the project.
    #
    attr_accessor :build_phases

    # @!group File patterns

    #
    #   File patterns do not support traversing the parent directory ( `..` ).
    #   File patterns may contain the following wildcard patterns:
    #
    #   ---
    #
    #   ### Pattern: *
    #
    #   Matches any file. Can be restricted by other values in the glob.
    #
    #   * `*` will match all files
    #   * `c*` will match all files beginning with `c`
    #   * `*c` will match all files ending with `c`
    #   * `*c*` will match all files that have `c` in them (including at the
    #     beginning or end)
    #
    #   Equivalent to `/.*/x` in regexp.
    #
    #   **Note** this will not match Unix-like hidden files (dotfiles). In
    #   order to include those in the match results, you must use something
    #   like `{*,.*}`.
    #
    #   ---
    #
    #   ### Pattern: **
    #
    #   Matches directories recursively.
    #
    #   ---
    #
    #   ### Pattern: ?
    #
    #   Matches any one character. Equivalent to `/.{1}/` in regexp.
    #
    #   ---
    #
    #   ### Pattern: [set]
    #
    #   Matches any one character in set.
    #
    #   Behaves exactly like character sets in Regexp, including set negation
    #   (`[^a-z]`).
    #
    #   ---
    #
    #   ### Pattern: {p,q}
    #
    #   Matches either literal `p` or literal `q`.
    #
    #   Matching literals may be more than one character in length. More than
    #   two literals may be specified.
    #
    #   Equivalent to pattern alternation in regexp.
    #
    #   ---
    #
    #   ### Pattern: \
    #
    #   Escapes the next meta-character.
    #
    #   ---
    #
    #   ### Examples
    #
    #   Consider these to be evaluated in the source root of
    #   [JSONKit](https://github.com/johnezang/JSONKit).
    #
    #       "JSONKit.?"    #=> ["JSONKit.h", "JSONKit.m"]
    #       "*.[a-z][a-z]" #=> ["CHANGELOG.md", "README.md"]
    #       "*.[^m]*"      #=> ["JSONKit.h"]
    #       "*.{h,m}"      #=> ["JSONKit.h", "JSONKit.m"]
    #       "*"            #=> ["CHANGELOG.md", "JSONKit.h"]

    #-----------------------------------------------------------------------#

    # @return [Array or String] files to include for the target.
    #                           Supports regular expressions,
    #                           Defaults to: ["./<Target Name>/*\*/\*.*"]
    #
    # @example
    #
    #     spec.include_files = "Classes/**/*.{h,m}"
    #
    attr_accessor :include_files

    # @return [Array or String] files to exclude for the target.
    #                           Supports regular expressions
    #
    # @example
    #
    #    spec.exclude_files = ["Classes/**/unused.{h,m}"]
    #
    attr_accessor :exclude_files

    # @!group Frameworks

    # @return [Array<String>] system frameworks to include for the target
    #                         Defaults to:
    #                          - ["Foundation", "UIKit"] for iOS
    #                          - ["Cocoa"] for OSX
    #
    # @example
    #
    #    spec.system_frameworks = ["Foundation"]
    #
    attr_accessor :system_frameworks

    # @return [Array<String>] system libraries to include for the target
    #
    # @example
    #
    #    spec.system_libraries = ["z", "sqlite3"]
    #
    attr_accessor :system_libraries

    # @return [Array<Target>] targets to use as dependencies
    #
    attr_accessor :target_dependencies

    # @param    [Proc] block
    #           an optional block that configures the project through the DSL.
    #
    # @example  Creating a Target.
    #
    #           Target.new do |t|
    #             t.name "test"
    #           end
    #
    def initialize(project)
      @project = project
      @build_phases = []

      yield(self) if block_given?
    end

    def include_files
      @include_files ||= ["./#{@name}/**/*.*"]
    end

    def exclude_files
      @exclude_files ||= []
    end

    def system_frameworks
      @system_frameworks ||= default_system_frameworks_for platform
    end

    def system_libraries
      @system_libraries ||= []
    end

    def target_dependencies
      @target_dependencies ||= []
    end

    # @!group Conversion

    def to_s
      "Target<#{name}>"
    end

    protected

    def default_system_frameworks_for(platform)
      case platform
      when :ios
        %w(Foundation UIKit)
      when :osx
        ['Cocoa']
      when :tvos
        %w(Foundation UIKit)
      when :watchos
        %w(Foundation UIKit WatchKit)
      else
        abort 'Platform not supported!'
      end
    end

    # Configurable

    def parent_configurable
      @project
    end

    # TODO: Move this to a constant, maybe Xcodeproj ones should be brought
    # into here?
    def default_settings
      {
        'INFOPLIST_FILE' => "#{name}/Supporting Files/Info.plist"
      }
    end

    def default_debug_settings
      Xcodeproj::Project::ProjectHelper
        .common_build_settings(:debug,
                               platform,
                               deployment_target.to_s,
                               type,
                               language).merge!(default_settings)
    end

    def default_release_settings
      Xcodeproj::Project::ProjectHelper
        .common_build_settings(:release,
                               platform,
                               deployment_target.to_s,
                               type,
                               language)
        .merge!(default_settings)
    end
  end
end
