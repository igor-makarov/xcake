

module Xcake
  class Configuration

    SUPPORTED_DEVICES = {
      :iphone_only: "1",
      :ipad_only: "2",
      :universal: "1,2"
    }

    def supported_devices=(devices)
      supported_devices = SUPPORTED_DEVICES[devices]
      settings["TARGETED_DEVICE_FAMILY"] = supported_devices
    end
  end
end
