module Xcake
  # This class is used to describe a scheme for a
  # Xcode project; This forms part of the DSL
  # and is usually stored in files named `Cakefile`.
  #
  class Scheme
    include Visitable

    def initialize
      yield(self) if block_given?
    end
  end
end
