require 'xcodeproj'

#TODO: Figure out a more robust Dependency system
# - Implement a pre-dependency (Something that this needs to happen in front of)

module Xcake
  module Dependency

    def self.included(base)
        base.extend ClassMethods
    end

    module ClassMethods
      def name
        self
      end

      def dependencies
        []
      end
    end
  end
end
