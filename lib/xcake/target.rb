module Xcake
  class Target

    attr_accessor :name
    attr_accessor :type
    attr_accessor :platform
    attr_accessor :include_files
    attr_accessor :exclude_files

    def initialize(name, type, platform, &block)
      self.name = name
      self.type = type
      self.platform = platform

      block.call(self) if block_given?
    end
  end
end
