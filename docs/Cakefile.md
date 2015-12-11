#Cakefile Syntax Reference

The `Cakefile` contains a lightweight DSL which provides the instructions on how to generate
a project file. We adopt the convention over configuration and thus it can be very simple:

```ruby
Project.new do |project|
    project.application_for :ios, 8.0 do |target|
        target.name = "MyApp"
    end
end
```

and here is much more complicated one:

```ruby
Project.new do |project|

    project.debug_configuration :staging
    project.debug_configuration :debug
    project.release_configuration :release

    project.application_for :ios, 8.0 do |target|
      target.name = "test"
      target.all_configurations.supported_devices = :iphone_only

      project.unit_tests_for(target)
    end
end
```

As you can see, it is super easy to read; The goal of Xcake is to keep everything
readable, efficient and concise.

## Project

To create a project we must write the following:

```ruby
Project.new do |project|
end
```
By default Xcake will create a project named "Project" but we can change the name
by passing a String argument with the name we would like it to be called:

```ruby
Project.new "Workspace" do |project|
end
```
We can also customize the structure of the project between the first and second lines, like so:

```ruby
Project.new "Workspace" do |project|
  project.debug_configuration :debug
end
```
There are two main ways you can customize a Project, Targets and Configurations.

###Properties

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
Project.new "Workspace" do |project|
  project.application_for :ios, 8.0
end
```

Mac App:

```ruby
Project.new "Workspace" do |project|
  project.application_for :mac, 8.0
end
```

###Tests

We can also specify a testing targets for other targets as well

```ruby
Project.new "Workspace" do |project|
  project.application_for :mac, 8.0 do |target|
    project.unit_tests_for(target)
  end
end
```

###Custom Targets

If these aren't enough for you then you can specify a target
and manually set up it's properties.

```ruby
Project.new "Workspace" do |project|
  project.target do |target|
    target.name = "Target"
  end
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

## Configurations

Configurations are an abstraction of build settings and scheme settings. Depending
on the target Xcake will create a scheme per target and per configuration.

Xcake allows you define a hierarchy of build settings like you would in Xcode
for the Project and the Targets.

### Debug Configurations

For configurations used for internal testing we create a debug configuration,
this comes with sensible defaults optimized for debugging (i.e Assertions enabled).

```ruby
project.debug_configuration :staging
```

### Release Configurations

For configurations used for release we create a release configuration,
this comes with sensible defaults optimized for releasing (i.e Compiler optimizations enabled).

```ruby
project.release_configuration :release
```

### All Configurations

We can apply a particular shared setting across all of our configurations.
Xcake provides a simply way of doing this via an "all" configuration.

```ruby
project.all_configurations.supported_devices = :iphone_only
```

### Configuration Hiearchy

Xcake allows you to manage the configurations for the project and the target but
it also has its own hiearchy of settings, which are in the following order
(One at the top of the list are overwritten by ones at the bottom):

- Default Settings
  These are the sensible defaults xcake provides for the configuration.

- All Settings
  These are any settings set via the "All" configuration

- Custom Settings
  These are the settings set directly on the configuration.

###Properties

#### Name

Sets the name of the configuration

```ruby
configuration.name = "Release"
```

#### Build Settings

A hash of all the build settings for a configuration

```ruby
configuration.build_settings["ENABLE_BITCODE"] = false
```

###Build Settings Shortcuts

Xcake also provides some shortcuts for some more common build settings.

#### Supported Devices

Allows you specify the devices an iOS App can run on, can be `:iphone_only`,
`:ipad_only` or `:universal`

```ruby
configuration.supported_devices = :iphone_only
```
