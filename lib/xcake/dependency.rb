require 'xcodeproj'

#TODO: Figure out a more robust Dependency system
# - Needs to handle subclass of subclass.....
# - Needs to have better mixin hiearchy
# - Implement a pre-dependency (Something that this needs to happen in front of)

module Xcake
  module Dependency
    module ClassMethods
      def name
        self
      end

      def dependencies
        []
      end
    end

    def self.included(klass)
      klass.extend ClassMethods  # Somewhat controversial
    end
  end
end
