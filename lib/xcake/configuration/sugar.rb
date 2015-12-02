module Xcake
  class Configuration

    # @return [Hash<Symbol, String>] the constants for the
    #                                supported_devices setting
    #
    SUPPORTED_DEVICES = {
      iphone_only: "1",
      ipad_only: "2",
      universal: "1,2"
    }

    # Convienence method to easily set the
    # supported devices for a application.
    #
    # Use this when you want to make a
    # Non-Univeral iOS application.
    #
    # @example Using Supported Devices
    #
    #          Target.new do |t|
    #             t.all_configurations.supported_devices = :ipad_only
    #          end
    #
    def supported_devices=(devices)
      supported_devices = SUPPORTED_DEVICES[devices]
      settings["TARGETED_DEVICE_FAMILY"] = supported_devices
    end
  end
end
