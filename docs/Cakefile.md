<!-- TODO: Maybe split into files ? -->
#Cakefile Syntax Reference

The `Cakefile` contains a lightweight DSL which provides the instructions on how to generate
a project file. We adopt the convention over configuration and thus it can be very simple:

```ruby
Project.new do |c|
    c.application_for :ios, 8.0 do |t|
        t.name = "MyApp"
    end
end
```

and here is much more complicated one:

```ruby
Project.new do |c|

    c.debug_configuration :staging
    c.debug_configuration :debug
    c.release_configuration :release

    c.application_for :ios, 8.0 do |t|
      t.name = "test"
      t.all_configurations.supported_devices = :iphone_only

      c.unit_tests_for(t)
    end
end
```

As you can see, it is super easy to read; The goal of Xcake is to keep everything
readable, efficient and concise.

## Project

To create a project we must write the following:

```ruby
Project.new do |c|
end
```
By default Xcake will create a project named "Project" but we can change the name
by passing a String argument with the name we would like it to be called:

```ruby
Project.new "Workspace" do |c|
end
```
We can also customize the structure of the project between the first and second lines, like so:

```ruby
Project.new "Workspace" do |c|
  c.debug_configuration :debug
end
```
There are two main ways you can customize a Project, Targets and Configurations.

## Targets

Targets are the way we make products such as Applications, Extensions, Libraries and Tests.
Xcake provides some easy ways to produce these types of targets but also
allows you to drop down a level if you need more power.

###Applications

A project can specify any application targets such as iOS or Mac Apps.

iOS App:

```ruby
Project.new "Workspace" do |c|
  c.application_for :ios, 8.0
end
```

Mac App:

```ruby
Project.new "Workspace" do |c|
  c.application_for :mac, 8.0
end
```

###Tests

We can also specify a testing targets for other targets as well

```ruby
Project.new "Workspace" do |c|
  c.application_for :mac, 8.0 do |t|
    c.unit_tests_for(t)
  end
end
```

###Custom Targets

If these aren't enough for you then you can specify a target
and manually set up it's properties.

```ruby
Project.new "Workspace" do |c|
  c.target do |t|
    t.name = "Target"
  end
end
```

###Properties

#### Name

Sets the name of the project

```ruby
t.name = "Target"
```

#### Type

Sets the type of the target, Can be `:application`, `:dynamic_library`,
`:framework` or `:static_library`.

```ruby
t.type = :application
```

#### Platform

Sets the platform of the target. Can be `:ios` or `:osx`

```ruby
t.platform = :ios
```

#### Deployment Target

Sets the deployment target for the platform.

```ruby
t.deployment_target = 8.0
```

#### Language

Sets the primary language of the target, can be `:objc` or `:swift`.

```ruby
t.language = :swift
```

## Configurations

### Debug Configurations

### Release Configurations

### All Configurations

### Configuration Hiearchy

###Properties

#### Build Settings
