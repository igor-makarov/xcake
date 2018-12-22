module Xcake
  # This class is used to describe a scheme for a
  # Xcode project; This forms part of the DSL
  # and is usually stored in files named `Cakefile`.
  #
  class Scheme
    include Visitable

    # The name for the scheme
    #
    attr_accessor :name

    # The configuration to use when testing
    #
    # Defaults to "Debug"
    #
    attr_accessor :test_configuration

    # The configuration to use when launching
    #
    # Defaults to "Debug"
    #
    attr_accessor :launch_configuration

    # The configuration to use when profiling
    #
    # Defaults to "Debug"
    #
    attr_accessor :profile_configuration

    # The configuration to use when analyzing
    #
    # Defaults to "Debug"
    #
    attr_accessor :analyze_configuration

    # The configuration to use when archving
    #
    # Defaults to "Release"
    #
    attr_accessor :archive_configuration

    def initialize(name)
      @name = name
      @test_configuration = 'Debug'
      @launch_configuration = 'Debug'
      @profile_configuration = 'Debug'
      @analyze_configuration = 'Debug'
      @archive_configuration = 'Release'

      yield(self) if block_given?
    end
  end
end
