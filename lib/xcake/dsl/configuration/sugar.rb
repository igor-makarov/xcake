module Xcake
  class Configuration
    # @return [Hash<Symbol, String>] the constants for the
    #                                supported_devices setting
    #
    SUPPORTED_DEVICES = {
      iphone_only: '1',
      ipad_only: '2',
      universal: '1,2'
    }.freeze

    # Convienence method to easily set the
    # supported devices for a application.
    #
    # Use this when you want to make a
    # Non-Univeral iOS application.
    #
    # @example Using Supported Devices
    #
    #          Target.new(project) do |t|
    #             t.all_configurations.each do |c|
    #                c.supported_devices = :ipad_only
    #             end
    #          end
    #
    def supported_devices=(devices)
      supported_devices = SUPPORTED_DEVICES[devices]
      settings['TARGETED_DEVICE_FAMILY'] = supported_devices
    end

    # Convienience method to easily set the
    # product's bundle identifier
    #
    def product_bundle_identifier=(identifier)
      settings['PRODUCT_BUNDLE_IDENTIFIER'] = identifier
    end

    # Convienence method to easily set preprocessor directives
    #
    def preprocessor_definitions
      PreprocessorDefinitionsSettingProxy.new(
        settings,
        'GCC_PREPROCESSOR_DEFINITIONS'
      )
    end
  end
end
