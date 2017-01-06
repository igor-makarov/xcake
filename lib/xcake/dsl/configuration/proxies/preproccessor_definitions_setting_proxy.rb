module Xcake
  class Configuration
    # This class is a proxy to the Preprocessor build
    # setting. It abstracts the setting of the value
    # for this setting and makes it easier to define
    # new preprocessor definitions.
    #
    class PreprocessorDefinitionsSettingProxy
      # the settings for the configuration this
      # proxy is for
      #
      # @return [Hash<String, Object>] the settings for the
      #                                proxied configuration
      #
      attr_accessor :settings

      # @return [String] the key for the settings where the
      #                  preprocessor definitions are kept
      #
      attr_accessor :key

      # @param    [Hash<String, Object>] settings
      #           the settings for the proxied configuration
      #
      # @param    [String] key
      #           the key for the settings where the preprocessor
      #           definitions are kept
      #
      def initialize(settings, key)
        @settings = settings
        @key = key
        @settings[@key] ||= ['$(inherited)']
      end

      # The subscript operator is used to define the preprocessor defination
      #
      # @param    [String] key
      #           the key for the preprocessor definition
      #
      # @param    [Object] value
      #           the value for the preprocessor definition
      #
      def []=(key, value)
        @settings[@key] << "#{key}=#{value}"
      end
    end
  end
end
