project_name = "Sup"
class_prefix = "SUP"

app_product_bundle_identifier = "com.forever-beta.sup"

debug_configuration :Debug do |configuration|
  configuration.preprocessor_definitions["SUP_FIREBASE_URL"] = "https://suptest.firebaseIO.com".to_obj_c
  configuration.preprocessor_definitions["MIXPANEL_TOKEN"] = "68c8d3e179fe62348f36fed57603bef2".to_obj_c
  configuration.settings["BRANCH_KEY"] = "key_test_hioVGQuxRZODjKtVX71YihghFvlLg6Ej"
end

debug_configuration :Beta do |configuration|
  configuration.preprocessor_definitions["SUP_FIREBASE_URL"] = "https://sup-snapshot.firebaseIO.com".to_obj_c
  configuration.preprocessor_definitions["MIXPANEL_TOKEN"] = "68c8d3e179fe62348f36fed57603bef2".to_obj_c
  configuration.settings["BRANCH_KEY"] = "key_test_hioVGQuxRZODjKtVX71YihghFvlLg6Ej"
end

release_configuration :Release do |configuration|
  configuration.preprocessor_definitions["SUP_FIREBASE_URL"] = "https://supdev.firebaseIO.com".to_obj_c
  configuration.preprocessor_definitions["MIXPANEL_TOKEN"] = "58d3635b5903ce7e3335a2731811c6e5".to_obj_c
  configuration.settings["BRANCH_KEY"] = "key_live_kehNLUFtMWKFbNxO043XndbmBCpPm9Ex"
end

application_for :ios, 8.4 do |target|

  target.name = "Sup"
  target.include_files << "SupCore/*.*"

  target.all_configurations.product_bundle_identifier = app_product_bundle_identifier
  target.all_configurations.settings["ENABLE_BITCODE"] = "NO"
  target.all_configurations.settings["GCC_PREFIX_HEADER"] = "SUP_PrefixHeader.pch"
  target.all_configurations.settings["SWIFT_OBJC_BRIDGING_HEADER"] = "Sup/Sup-Bridging-Header.h"
  target.all_configurations.supported_devices = :iphone_only

  unit_tests_for target

  watch_app_for target, 2.0 do |app, extension|

    extension.include_files << "SupCore/*.*"
    extension.all_configurations.settings["SWIFT_OBJC_BRIDGING_HEADER"] = "Sup-Watch Extension/Sup-Watch Extension-Bridging-Header.h"

    app.all_configurations.product_bundle_identifier = "#{app_product_bundle_identifier}.watchkitapp"
    extension.all_configurations.product_bundle_identifier = "#{app_product_bundle_identifier}.watchkitapp.watchkitextension"
  end
end
