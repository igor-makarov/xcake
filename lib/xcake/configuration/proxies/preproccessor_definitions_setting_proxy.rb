module Xcake
  class Configuration
    class PreprocessorDefinitionsSettingProxy

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
        @settings[@key] ||= ["$(inherited)"]
      end

      # Document
      #
      def []=(key, value)
        @settings[@key] << "#{key}=#{value}"
      end
    end
  end
end
