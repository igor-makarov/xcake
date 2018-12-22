module Xcake
  # This class is used to describe a build rule for a
  # Xcode project; This forms part of the DSL
  # and is usually stored in files named `Cakefile`.
  #
  class BuildRule
    # @return [String] the name of the rule.
    #
    attr_accessor :name

    # @return [String] the type of the files that should be processed by
    #         this rule.
    #
    # @example
    #   `pattern.proxy`.
    #
    attr_accessor :file_type

    # @return [ObjectList<PBXFileReference>] the file references for the
    #         output files.
    #
    attr_accessor :output_files

    # @return [ObjectList<String>] the compiler flags used when creating the
    #         respective output files.
    #
    attr_accessor :output_files_compiler_flags

    # @return [String] the content of the script to use for the build rule.
    #
    # @note   This attribute is present if the #{#compiler_spec} is
    #         `com.apple.compilers.proxy.script`
    #
    attr_accessor :script

    # @param    [Proc] block
    #           an optional block that configures the build rule through the DSL.
    #
    # @example  Creating a Build Rule.
    #
    #           BuildRule.new do |p|
    #             p.name "test"
    #           end
    #
    def initialize
      @output_files = []
      @output_files_compiler_flags = []

      yield(self) if block_given?
    end

    # This method is called when generating the build rules
    # subclasses should implement this to handle the
    # configuration of the build phase
    #
    def configure_native_build_rule(native_build_rule, _context)
      native_build_rule.name = name
      native_build_rule.compiler_spec = 'com.apple.compilers.proxy.script'
      native_build_rule.file_type = file_type
      native_build_rule.script = script.strip_heredoc
      if output_files_compiler_flags.empty?
        output_files.each do |file|
          native_build_rule.add_output_file(file)
        end
      else
        output_files.zip(output_files_compiler_flags).each do |file, flag|
          native_build_rule.add_output_file(file, flag)
        end
      end
    end

    def to_s
      "BuildRule<#{name}>"
    end
  end
end
