module Xcake
  class BuildConfiguration
    attr_accessor :name
    attr_accessor :settings

    def initialize(name, &block)
      self.name = name
      self.settings = {}
      
      block.call(self) if block_given?
    end
  end
end
