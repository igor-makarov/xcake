module Xcake
  class Configuration

    #TODO: Add sugar to Configurations.

    include Visitable

    attr_accessor :name
    attr_accessor :settings

    def initialize(name, &block)
      self.name = name.to_s
      self.settings = {}

      block.call(self) if block_given?
    end
  end
end
