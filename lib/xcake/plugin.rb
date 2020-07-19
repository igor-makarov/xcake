module Xcake
  module Plugin
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      include CoreExtensions::ClassDescendants

      def load_plugins
        Dir[plugins_location].each { |file| require file }
        descendants
      end

      def plugins_location
      end
    end
  end
end
