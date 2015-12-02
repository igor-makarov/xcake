# Getting Started

Xcake allows you to describe a Xcode project via an easy to use DSL, We do this
by creating a simple text file, our `Cakefile`. This tutorial will show you how
to create your first project.

Our first step is to create the folder for our project and a blank file for our `Cakefile`,
so we're going to need some command line magic:

- Firstly run `mkdir MyProject` to create the folder for our project
- Next we will need a blank textfile, so lets run `touch Cakefile` to create it

So we should have a folder called "MyProject" with a textfile named "Cafekile" inside of it,
Xcake will look for this textfile, so make sure to keep it's name the same.

This is all great but there are still no signs of a Project; Don't worry we still need to
write some code to describe what the project should look like. So our first step is declaring
we want to create a new project.

So now in your textfile, type the following:

  Project.new do |c|
  end

This code is quite clearly telling xcake to create a new project.
