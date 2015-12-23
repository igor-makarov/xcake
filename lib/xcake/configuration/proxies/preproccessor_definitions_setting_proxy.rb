module Xcake
  class Configuration
    class PreprocessorDefinitionsSettingProxy

      # Document
      #
      attr_accessor :setting

      # Document
      #
      def initialize(setting)
        @setting = setting
      end

      # Document
      #
      def []=(key, value)
        @setting ||= ["$(inherited)"]
        @setting << "#{key}=#{value}"
      end
    end
  end
end
