# Carthage
[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager for iOS. Unlike CocoaPods, Carthage avoids modifying your Xcode project files by design and instead has you manually perform the necessary modifications.

There are 3 steps you need to perform to integrate Carthage frameworks into your project.

1. Link the frameworks to the target
2. Add Carthage to the framework search paths
3. Embed the frameworks
    - (macOS) Embed Frameworks Build Phase
    - (Other) Use carthage copy-frameworks

## Link frameworks to the target
You can link frameworks using `include_files`. You can provide the names of specific frameworks or use a pattern like `*.framework` to link everything.
```ruby
target.include_files << "Carthage/Build/iOS/MyFramework.framework"
target.include_files << "Carthage/Build/iOS/MyOtherFramework.framework"
```

## Add Carthage to framework search paths
The build system won't be able to find Carthage frameworks unless you add them to the framework search paths for all target configurations that use them.
```ruby
configuration.settings["FRAMEWORK_SEARCH_PATHS"] = "Carthage/Build/**"
```

## macOS: Embed Frameworks
You can add a `copy_files_build_phase` to embed frameworks used by Carthage.
```ruby
target.copy_files_build_phase "Embed Frameworks" do |phase|
    phase.files = [
        "Carthage/Build/iOS/MyFramework.framework",
        "Carthage/Build/iOS/MyOtherFramework.framework"
    ]
    phase.destination = :frameworks

    # This controls the Code Sign on Copy setting under Build Phases in Xcode
    phase.code_sign = true
end
```

## iOS, watchOS, tvOS: Copy Frameworks
[Carthage suggests](https://github.com/Carthage/Carthage#if-youre-building-for-ios-tvos-or-watchos) you run the `carthage copy-frameworks` command instead of embedding frameworks yourself. This can be accomplished with a `shell_script_build_phase`. However, Xcake doesn't have a facility to specify Input Files at the time of this writing. You will need to run a script that sets the environment variables Carthage expects to see.
```ruby
target.shell_script_build_phase 'Copy Carthage Frameworks', <<-SCRIPT
    export SCRIPT_INPUT_FILE_COUNT=2
    export SCRIPT_INPUT_FILE_0=${SRCROOT}/Carthage/Build/iOS/MyFramework.framework
    export SCRIPT_INPUT_FILE_1=${SRCROOT}/Carthage/Build/iOS/MyOtherFramework.framework
    carthage copy-frameworks
SCRIPT
```
