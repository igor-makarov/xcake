module Xcake
  class BuildConfiguration
    attr_accessor :name

    def initialize(name, &block)
      self.name = name
      block.call(self) if block_given?
    end
  end
end
