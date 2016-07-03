#Cakefile Syntax Reference

The `Cakefile` contains a lightweight DSL which provides the instructions on how to generate
a project file. We adopt the convention over configuration and thus it can be very simple:

```ruby
  application_for :ios, 8.0 do |target|
      target.name = "MyApp"
  end
```

and here is much more complicated one:

```ruby
  debug_configuration :staging
  debug_configuration :debug
  release_configuration :release

  application_for :ios, 8.0 do |target|
    target.name = "test"
    target.all_configurations.each { |c| c.supported_devices = :iphone_only }

    unit_tests_for target
  end
```

As you can see, it is super easy to read; The goal of Xcake is to keep everything
readable, efficient and concise.

## Project

A project is automatically created from a `Cakefile`. To customize a Project
you can easily access all of it's properties via the `project` method.

```ruby
project do |p|
  p.project_name = "Project"
end
```

You can also directly set the properties without a block, like so:

```ruby
project.project_name = "Project"
```

###Properties

#### Project Name

Sets the filename for the project

```ruby
project.name = "Project"
```

#### Class Prefix

Sets the class prefix for the project

```ruby
project.class_prefix = "XC"
```

#### Organization

Sets the organization for the project.

```ruby
project.organization = "Xcake Productions"
```

## Targets

Targets are the way we make products such as Applications, Extensions, Libraries and Tests.
Xcake provides some easy ways to produce these types of targets but also
allows you to drop down a level if you need more power.

###Applications

A project can specify any application targets such as iOS or Mac Apps.

iOS App:

```ruby
application_for :ios, 8.0
```

Mac App:

```ruby
application_for :mac, 8.0
```

###Tests

We can also specify a testing targets for other targets as well:

```ruby
application_for :mac, 8.0 do |target|
  unit_tests_for target
end
```

The above code will create a complementary unit tests target for the `target`. The unit tests target name will be default `<target.name>Tests`, so if your `target.name` is "MyFirstApp" then your unit tests target will be named "MyFirstAppTests", and Xcake will include any files that are placed under folder with the same name/path (if it exists).

If you want to manually control configuration of unit tests targets (and/or have multiple ones), then you should do like this:

```ruby
application_for :mac, 8.0 do |target|

  unit_tests_for target do |test_target|

        test_target.name = "MyAwesomeTests"
        test_target.include_files = ["Tests/**/*.*"]

        # configure any other target-related properties
        # as you would do with normal target

    end
end
```

###Watch

To create watch applications we can simply use the `watch_app_for` method:

```ruby
application_for :mac, 8.0 do |target|
    watch_app_for target, 2.0
end
```

###Custom Targets

If these aren't enough for you then you can specify a target
and manually set up it's properties.

```ruby
target do |target|
    target.name = "Target"
end
```

###Properties

#### Name

Sets the name of the target

```ruby
target.name = "Target"
```

#### Type

Sets the type of the target, Can be `:application`, `:dynamic_library`,
`:framework` or `:static_library`.

```ruby
target.type = :application
```

#### Platform

Sets the platform of the target. Can be `:ios`, `:osx`, `:tvos` or `:watchos`

```ruby
target.platform = :ios
```

#### Deployment Target

Sets the deployment target for the platform.

```ruby
target.deployment_target = 8.0
```

#### Language

Sets the primary language of the target, can be `:objc` or `:swift`.

```ruby
target.language = :swift
```

#### Include Files

Sets the files to be included for a target, files and groups will be added
to the project to match the file system.

[See Here](https://guides.cocoapods.org/syntax/podspec.html#group_file_patterns)
for file patterns

```ruby
target.include_files = ["FolderOne/*.*"] # array
target.include_files << "FolderTwo/**/*.*" # add an item to array
```

#### Exclude Files

Sets the files to be excluded for a target, if no target uses these files they
will be excluded from the project

[See Here](https://guides.cocoapods.org/syntax/podspec.html#group_file_patterns)
for file patterns

```ruby
target.exclude_files = ["FolderToIgnore/*.*"] # array
target.exclude_files << "OtherFolderToIgnore/*.*" # add an item to array
```

## Configurations

Configurations are an abstraction of build settings and scheme settings. Depending
on the target Xcake will create a scheme per target and per configuration.

Xcake allows you define a hierarchy of build settings like you would in Xcode
for the Project and the Targets.

### Debug Configurations

For configurations used for internal testing we create a debug configuration,
this comes with sensible defaults optimized for debugging (i.e Assertions enabled).

```ruby
debug_configuration :staging
```

We can modify settings for each configuration easily.

```ruby
debug_configuration :staging do |configuration|
  configuration.settings["KEY"] = "VALUE"
end
```

### Release Configurations

For configurations used for release we create a release configuration,
this comes with sensible defaults optimized for releasing (i.e Compiler optimizations enabled).

```ruby
release_configuration :release
```

We can modify settings for each configuration easily.

```ruby
release_configuration :release do |configuration|
  configuration.settings["KEY"] = "VALUE"
end
```

### All Configurations

We can apply a particular shared setting across all of our configurations.
Xcake provides a simply way of doing this via an "all" configuration.

This will return an array of all of the currently declared configurations.

```ruby
all_configurations.each { |c| c.supported_devices = :iphone_only }
```

### Targets

To modify settings for certain target, then its as simple as prefixing the
target we want to modify the configuration for.

```ruby

target.all_configurations.each { |c| c.supported_devices = :iphone_only }

debug_configuration :staging do |configuration|
  configuration.settings["KEY"] = "VALUE"
end

target.release_configuration :release do |configuration|
  configuration.settings["KEY"] = "VALUE"
end
```

### Configuration Hiearchy

Xcake allows you to manage the configurations for the project and the target but
it also has its own hiearchy of settings, which are in the following order
(One at the top of the list are overwritten by ones at the bottom):

- Default Settings
  These are the sensible defaults xcake provides for the configuration.

- Custom Settings
  These are the settings set directly on the configuration.

###Properties

#### Name

Sets the name of the configuration

```ruby
configuration.name = "Release"
```

#### Configuration File

Sets the path to a XCConfig to inherit build settings from.

```ruby
configuration.configuration_file = "Files/Settings.xcconfig"
```

#### Build Settings

A hash of all the build settings for a configuration

```ruby
configuration.settings["ENABLE_BITCODE"] = false
```

### Build Settings Shortcuts

Xcake also provides some shortcuts for some more common build settings.

#### Supported Devices

Allows you specify the devices an iOS App can run on, can be `:iphone_only`,
`:ipad_only` or `:universal`

```ruby
configuration.supported_devices = :iphone_only
```

#### Product Bundle Identifier

Allows you specify the product bundle identifier.

```ruby
configuration.product_bundle_identifier = "com.test.app"
```

#### Preprocessor Definitions

Allows you to specify preprocessor definitions.

```ruby
configuration.preprocessor_definitions["NAME"] = "VALUE"
```
