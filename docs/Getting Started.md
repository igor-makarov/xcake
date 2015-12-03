# Getting Started

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

This is all great but there are still no signs of a Project; Don't worry we still need to
write some code to describe what the project should look like. So our first step is declaring
we want to create a new project.

So now in your textfile, type the following:

    Project.new do |c|
    end

This code is quite clearly telling xcake to create a new project; So lets see what happens.
If we go to our folder and run `xcake` we should now have our xcode project. *phew* that was easy!

If we open it however it's not quite ready to use, it's still lacking any targets to actually build.
So let's fix that :)

We're going to create an app for iOS 9.0 called `MyApp`, hopefully the syntax should be easy to grasp:

    Project.new do |c|
      c.application_for :ios, 9.0 do |t|
        t.name = "MyApp"
      end
    end

Now if we run `xcake` again, we get the same project file but now with a target. In addition to this
xcake has created a `debug` and `release` build configuration as well as two schemes for our target
and these build configurations.

For some situations you may want to provide your own build configurations, for example adding a
staging build configuration. So now we will specify our own `staging` configuration, this configuration will be used for internal testing so we will specify that it should
be a `debug` configuration so that the default build settings are optimised for testing.

So lets add it, configurations are defined project-wide so we do it like this:

    Project.new do |c|

      c.debug_configuration :staging

      c.application_for :ios, 9.0 do |t|
        t.name = "MyApp"
      end

    end

Again we run `xcake` and voilla! Pretty easy but now if we open up our project
our `debug` and `release` configurations are gone. Why is that?
