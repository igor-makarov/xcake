# App Extensions
There are 3 main things to do to get Xcake to generate a fully working App Extension.

1. Create the extension target
2. Create an Embed App Extensions build phase
3. (Workaround) Use `after_save` to copy schemes for extension debugging

## Create the extension target
An App Extension target can be defined using `extension_for`. The following code sample demonstrates some of the required attributes and caveats of their usage. Note that app extension targets do not need to be linked to their containing target.
```ruby
extension_for main_target do ext_target
    ext_target.name = "MyExtension"

    ext_target.all_configurations.each do |configuration|
        configuration.product_bundle_identifier = "com.MyApp.MyExtension"
        configuration.settings["INFOPLIST_FILE"] = "MyExtensionPath/Info.plist"
        configuration.settings["LD_RUNPATH_SEARCH_PATHS"] = "$(inherited) @executable_path/Frameworks"
        configuration.settings["ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES"] = "YES"
    end

    ext_target.system_frameworks = ["NotificationCenter"]
end
```

- `configuration.product_bundle_identifier`
    - Must use the main app's bundle identifier as a prefix. For example, if your main app's bundle identifier is `"com.MyApp"`, the app extension must have a bundle identifier like `"com.MyApp.MyExtension"`.
- `target.system_frameworks`
    - Must be set appropriately based on the type of extension it is. Today Extensions, for example, require `NotificationCenter`. You may want to try creating an App Extension in Xcode or referencing a pre-existing one to see which system frameworks are included for that extension type.

You may also need to explicitly add `include_files` and `exclude_files` depending on how your project is structured. Xcake will infer some of these things based on the names of targets and folders, so you can try just running `xcake make` and seeing if anything is missing.

A common use case might be to have a Shared folder for files like commonly used asset catalogs or source files. The contents of this folder will need to be manually added to `include_files` using a pattern like `Shared/**/*.*`.

## Create an Embed App Extensions build phase
Use `copy_files_build_phase` to copy the app extension into the containing app.
```ruby
main_target.copy_files_build_phase "Embed App Extensions" do |phase|
    phase.destination = :plug_ins
    phase.files = ["Products/MyExtension.appex"]
end
```

## Copy schemes for extension debugging
This section is a workaround. Once Xcake is updated to generate appropriate schemes for app extension targets, it will no longer be necessary.

Xcake provides a limited amount of customization related to schemes. The scheme it creates for your app extension will not work for debugging. To make it so a working scheme for debugging is available after running `xcake make`, you'll need to do the following:

1. Once you've completed the first two parts of this guide, run `xcake make` and open the generated project in Xcode.
2. Click on the Schemes list in the upper left and select "New Scheme".
3. In the dialog that pops up, set the target to your app extension target. Click OK.
4. Find the `.xcscheme` you created in Xcode somewhere in the `MyProject.xcodeproj/` folder. You'll probably find it under `xcuserdata`.
5. Make copies of this scheme into a safe place. For instance, you can create a folder `.xcake/` in the project root. Name the copies identical to the generated schemes produced by Xcake, e.g. `"MyExtension-Debug.xcscheme"` and `"MyExtension-Release.xcscheme"`.
6. Modify your release scheme appropriately.
    - This may simply involve finding `buildConfiguration = "Debug"` and replacing with `buildConfiguration = "Release"`.

Now that you've created your extension schemes and copied them appropriately, create or modify an `after_save` hook for your project in your Cakefile that copies the schemes back in.

```ruby
project.after_save do
    system "cp .xcake/*.xcscheme MyProject.xcodeproj/xcshareddata/xcschemes/"
end
```
