# Xcake
[![Gem](https://img.shields.io/gem/v/xcake.svg)](https://rubygems.org/gems/xcake)
[![Twitter: @jcampbell_05](https://img.shields.io/badge/contact-@jcampbell_05-blue.svg?style=flat)](https://twitter.com/jcampbell_05)
[![License](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/fastlane/fastlane/blob/master/LICENSE)
[![Build Status](https://img.shields.io/travis/jcampbell05/xcake/master.svg?style=flat)](https://travis-ci.org/jcampbell05/xcake)
[![Test Coverage](https://img.shields.io/coveralls/jcampbell05/xcake/master.svg)](https://coveralls.io/github/jcampbell05/xcake)
[![Gem](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-xcake)

###Xcode projects made a piece of cake.

You describe your project in a simple text file: your `Cakefile`.
Xcake creates your project based on this including importing all of your files and creating groups
to match the file hiearchy.

This is perfect for working in teams or with cocoapods as it reduces conflicts,
makes it easy to modify settings and allows you to create a clean project anytime you need to.

Isn't this just like liftoff, generamba or crafter? No these tools are for scafolding a whole project structure to get you started (Creating folder structure, git repo etc.). However xcake is not for this, xcake is just for generating a xcodeproject.

Get in contact with the developer on Twitter: [@jcampbell_05](https://twitter.com/jcampbell_05)

-------
<p align="center">
    <a href="#features">Features</a> &bull;
    <a href="#installation">Installation</a> &bull;
    <a href="#need-help">Need help?</a> &bull;
    <a href="http://www.rubydoc.info/github/jcampbell05/xcake/master/file/docs/Getting%20Started.md">Documentation</a>
</p>

-------

## Features

Xcode projects were once described as "the closest thing to taboo we have to deal with on a regular basis", but it doesnt have to be this way.

Store a simple description of your project in a text file, your `Cakefile`, to easily create a xcode project from _any_ computer. Easily see, merge and maintain the structure of your project, It’s time to add *.xcodeproj into .gitignore!.

You define a project like this:

```ruby
application_for :ios, 8.0 do |target|
  target.name = "MyApp"
end
```

To generate the xcode project, just run:

```sh
xcake make
```

If you would like an example Cakefile for guidence, just run:

```sh
xcake init
```

              |  xcake
--------------------------|------------------------------------------------------------
:sparkles: | Flexibly configure and create xcode project from one easy to read `Cakefile`
:ship: | Generate from any computer, including a CI-server
:thought_balloon: | Never remember any difficult commands, just `xcake make`
:page_with_curl: | Store **everything** but the project in git. Never again manually fix any corruptions or merge issues with the project.
:rocket: | Saves you **hours** when working with xcode projects
:anchor: | Confidence that the project file is exactly the same during Continuous Delivery
:computer: | Support for OSX, iOS and watchOS apps

## Installation

Install the gem by running:

    sudo gem install xcake --verbose

Make sure, you have the latest version of the Xcode command line tools installed:

    xcode-select --install

If you experience slow launch times of xcake, try running

    gem cleanup

to clean up outdated gems.

System Requirements: `xcake` requires Mac OS X or Linux with Ruby 2.0.0 or above.

## Available commands

Xcake can create an example cakefile when you run:

    xcake init

Usually you'll use xcake by running the command

    xcake make

Xcake will then generate a Xcode project based on your Cakefile

## Sample Cakefile

To get better understanding of how to start using Xcake in a real project, see examples under [example](https://github.com/jcampbell05/xcake/tree/master/example) folder.

There is a sample [app project](https://github.com/jcampbell05/xcake/blob/master/example/app/CakeMania) (the project file has been generated using Xcake v.0.7.1 based on the [Cakefile](https://github.com/jcampbell05/xcake/blob/master/example/app/CakeMania/Cakefile)) as well as sample [Cakefile](https://github.com/jcampbell05/xcake/blob/master/example/framework/Cakefile) for an iOS framework project.

## Need help?
Please submit an issue on GitHub and provide information about your setup

## License
This project is licensed under the terms of the MIT license. See the LICENSE file.

This project is no way affiliated with Apple Inc. This project is open source under the MIT license, which means you have full access to the source code and can modify it to fit your own needs. Xcake runs on your own computer or server, so your sensitive information will never leave your own computer. You are responsible for how you use xcake.
