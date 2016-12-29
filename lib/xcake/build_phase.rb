module Xcake
  # This class is used to describe a build phase for a
  # Xcode project; This forms part of the DSL
  # and is usually stored in files named `Cakefile`.
  #
  class BuildPhase

    #TODO: Document
    def initialize
      yield(self) if block_given?
    end

    # The Name of the build phase as shown in Xcode
    attr_accessor :name

    # TODO: Document
    def build_phase_type
      raise "build_phase_type not implemneted"
    end

    # This method is called when generating the build phases
    # subclasses should implement this to handle the 
    # configuration of the build phase
    #
    def configure_native_build_phase(native_build_phase, context)
      native_build_phase.name = name
    end
  end
end
