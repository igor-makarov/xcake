module Xcake
  class Target

    attr_accessor :name
    attr_accessor :include_files
    attr_accessor :exclude_files

    def initialize(name, &block)
      self.name = name

      block.call(self) if block_given?
    end
  end
end
