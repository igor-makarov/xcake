module Xcake
  class Cakefile
    attr_accessor :targets

    def initialize(&block)
      self.targets = []

      block.call(self) if block_given?
    end

    def target(name)
      self.targets << Target.new(name)
    end
  end
end
