# TODO: Figure out a more robust Plugin system
# - Needs to handle subclass of subclass.....
# - Needs to have better mixin hiearchy

module Xcake
  module Plugin
    module ClassMethods
      def repository
        @repository ||= []
      end

      def inherited(klass)
        repository << klass
      end
    end

    def self.included(klass)
      klass.extend ClassMethods # Somewhat controversial
    end
  end
end
