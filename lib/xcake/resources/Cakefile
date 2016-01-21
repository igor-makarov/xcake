# Change this to set a different Project file name
#project.project_name = "Project"

# Replace this with your class prefix for Objective-C files.
project.class_prefix = "APP"

# By default Xcake defaults to creating the standard Debug and Release
# configurations, uncomment these lines to add your own.
#
#debug_configuration :Staging
#debug_configuration :Debug
#release_configuration :Release

# Change these to the platform you wish to support (ios, osx) and the
# version of that platform (8.0, 9.0, 10.10, 10.11)
#
application_for :ios, 8.0 do |target|

    #Update these with the details of your app
    target.name = "YourApp"
    target.all_configurations.product_bundle_identifier = "com.yourcompany.yourapp"

    # Uncomment to target iPhone devices only
    #
    # File patterns can be seen here https://guides.cocoapods.org/syntax/podspec.html#group_file_patterns
    #
    #target.all_configurations.supported_devices = :iphone_only

    # Uncomment this to include additional files
    #
    #target.include_files << "FolderToInclude/*.*"

    # Uncomment this to exclude additional files
    #
    # File patterns can be seen here https://guides.cocoapods.org/syntax/podspec.html#group_file_patterns
    #
    #target.exclude_files << "ExcludeToInclude/*.*"

    # Uncomment to set your own build settings
    #
    #target.all_configurations.settings["ENABLE_BITCODE"] = "NO"
    #target.all_configurations.settings["GCC_PREFIX_HEADER"] = "APP-Prefix-Header.pch"
    #target.all_configurations.settings["SWIFT_OBJC_BRIDGING_HEADER"] = "APP-Bridging-Header.h"

    # Uncomment to define your own preprocessor macros
    #
    #target.all_configurations.preprocessor_definitions["API_ENDPOINT"] = "https://example.org".to_obj_c

    # Comment to remove Unit Tests for your app
    #
    unit_tests_for target

    # Uncomment to create a Watch App for your application.
    #
    #watch_app_for target, 2.0
end
