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

    protected

    # This method is called when generating the build phases
    # subclasses should implement this to handle the creation 
    # and configuration of the build phase
    #
    def generate_native_build_phase(target)
    end
  end
end
