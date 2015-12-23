module Xcake
  class Configuration
    class HashSettingProxy

      def initialize(build_settings, key)
        @build_settings = build_settings
        @key = key
      end

      def []=(key, value)
        #xcode_build_configuration = @xcode_build_configuration_list[configuration]
        #xcode_build_configuration.build_settings[@key] = value
      end
    end
  end
end
