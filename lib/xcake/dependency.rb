require 'xcodeproj'

#TODO: Figure out a more robust Dependency system
# - Implement a pre-dependency (Something that this needs to happen in front of)

module Xcake
  module Dependency
    def self.name
      self
    end

    def self.dependencies
      []
    end
  end
end
