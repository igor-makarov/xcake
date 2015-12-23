module Xcake
  class Configuration
    class ArraySettingProxy

      # Document
      #
      attr_accessor :settings

      # Document
      #
      attr_accessor :key

      # Document
      #
      def initialize(settings, key)
        @settings = settings
        @key = key
      end

      # Document
      #
      def []=(key, value)
        @settings[@key] ||= ["$(inherited)"]
        @settings[@key] << "#{key}=#{value}"
      end
    end
  end
end
