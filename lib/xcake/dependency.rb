require 'xcodeproj'

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
