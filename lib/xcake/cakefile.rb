
module Xcake
  class Cakefile
    attr_accessor :targets

    def initialize
      self.targets = []
    end

    def target
      self.targets << Target.new
    end
  end
end
