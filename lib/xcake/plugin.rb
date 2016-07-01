module Xcake
  module Plugin
    def self.included base
        base.extend ClassMethods
    end

    module ClassMethods
      def self.load_plugins
        Dir[plugins_location].each {|file| require file }
        descendants
      end

      def self.plugins_location
      end
    end
  end
end
