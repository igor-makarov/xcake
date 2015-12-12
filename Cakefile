Project.new do |c|
    c.application_for :ios, 8.0 do |t|
      t.name = "test"

      t.all_configurations.supported_devices = :iphone_only

      c.unit_tests_for t
      c.watch_app_for t, 2.0
    end
end
