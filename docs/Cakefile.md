#Cakefile Syntax Reference

The `Cakefile` contains a lightweight DSL which provides the instructions on how to generate
a project file, here is an example of a simple project:

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

###Tests

###Custom Targets

## Configurations
