require 'xcodeproj'

#TODO: Figure out a more robust Dependency system
# - Needs to handle subclass of subclass.....
# - Needs to have better mixin hiearchy

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
