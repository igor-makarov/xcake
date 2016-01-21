#Getting Started

Xcake allows you to describe a Xcode project via an easy to use DSL, We do this
by creating a simple text file, our `Cakefile`. This tutorial will show you how
to create your first project. This guide assumes you have a basic knowllege of
xcode.

Our first step is to create the folder for our project and a blank file for our `Cakefile`,
so we're going to need some command line magic:

- Firstly run `mkdir MyProject` to create the folder for our project
- Next we will need a blank textfile, so lets run `touch Cakefile` to create it

So we should have a folder called "MyProject" with a textfile named "Cakefile" inside of it,
Xcake will look for this textfile, so make sure to keep it's name the same.

Now, If we run `xcake make` we should now have our xcode project. *phew* that was easy! If we open it however it's not quite ready to use, it's still lacking any targets to actually build.
So let's fix that :)

We're going to create an app for iOS 9.0 called `MyApp`, hopefully the syntax should be easy to grasp:

```ruby
application_for :ios, 9.0 do |target|
  target.name = "MyApp"
end
```

Now if we run `xcake make` again, we get the same project file but now with a target. In addition to this
xcake has created a `debug` and `release` build configuration as well as two schemes for our target
and these build configurations.

For some situations you may want to provide your own build configurations, for example adding a
staging build configuration. So now we will specify our own `staging` configuration, this configuration will be used for internal testing so we will specify that it should
be a `debug` configuration so that the default build settings are optimised for testing.

So lets add it, configurations are defined project-wide so we do it like this:

```ruby
debug_configuration :staging

application_for :ios, 9.0 do |target|
  target.name = "MyApp"
end
```

Again we run `xcake make` and voilla! Pretty easy but now if we open up our project
our `debug` and `release` configurations are gone. Xcake operates an opt-out system, Xcode projects won't open
without any configurations so Xcake provides these configurations as a sensible default. But as soon as we
provide our own configurations we are opting out of these defaults.

Xcake does this to force us to make sure we have everything setup as we need it, to get these configurations back
its just an extra couple of lines:

```ruby
debug_configuration :staging
debug_configuration :debug
release_configuration :release

application_for :ios, 9.0 do |target|
  target.name = "MyApp"
end
```

And there you have it, that is your first project created by Xcake. To learn what else you can do, read the
[Cakefile syntax reference](Cakefile.md).
