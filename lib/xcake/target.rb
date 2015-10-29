module Xcake
  class Target

    attr_accessor :name
    attr_accessor :type
    attr_accessor :platform
    attr_accessor :deployment_target
    attr_accessor :include_files
    attr_accessor :exclude_files

    def initialize(&block)
      block.call(self) if block_given?
    end
  end
end
