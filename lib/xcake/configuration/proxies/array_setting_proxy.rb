module Xcake
  class Configuration
    class ArraySettingProxy

      def initialize(build_settings, key)
        @build_settings = build_settings
        @key = key
      end

      def []=(key, value)
        @build_settings[@key] ||= ["$(inherited)"]
        @build_settings[@key] << "#{key}=#{value}"
      end
    end
  end
end
