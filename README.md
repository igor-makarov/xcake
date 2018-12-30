# Xcake
[![Gem](https://img.shields.io/gem/v/xcake.svg)](https://rubygems.org/gems/xcake)
[![Twitter: @igormaka](https://img.shields.io/badge/contact-@igormaka-blue.svg?style=flat)](https://twitter.com/igormaka)
[![License](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/fastlane/fastlane/blob/master/LICENSE)
[![Build Status](https://img.shields.io/travis/igor-makarov/xcake/master.svg?style=flat)](https://travis-ci.org/igor-makarov/xcake)
[![Test Coverage](https://api.codeclimate.com/v1/badges/97d4476df2b0809a18ea/test_coverage)](https://codeclimate.com/github/igor-makarov/xcake/test_coverage)
[![Gem](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-xcake)

### Back under new management!

The original author of Xcake, [James Campbell](https://github.com/jcampbell05) has decided to move on to other endeavors.  
[Igor Makarov](https://github.com/igor-makarov) has volunteered to step in as the main maintainer, both because of his reliance on the gem for work, and because of general aversion to `.pbxproj` files.

### Cakefile — A Podfile for your main project!

Describe your project in a simple text file: your `Cakefile`.
Xcake generates your project based on this file including importing all of your files and creating groups and targets to match the file hierarchy.

This is perfect for working in teams or with CocoaPods as it reduces merge conflicts, makes it easy to modify settings and allows you to create a clean project anytime you need to.

Isn't this just like Generamba or Crafter?  
No, these tools are for scafolding an initial project structure to get you started (creating folder structure, git repo etc.).  
Xcake will not create a folder structure, but will generate a project from it, and will continue to generate it each time you want it. Added some files? Generate! Renamed a folder? Generate!  
Sick of seeing `.pbxproj` diffs in git? Add your project to `.gitignore` and generate it on checkout.


Get in contact with the developer on Twitter: [@igormaka](https://twitter.com/igormaka).

PBX delendare est.

-------
<p align="center">
    <a href="#features">Features</a> &bull;
    <a href="#installation">Installation</a> &bull;
    <a href="#need-help">Need help?</a> &bull;
    <a href="http://www.rubydoc.info/github/igor-makarov/xcake/master/file/docs/Getting%20Started.md">Documentation</a>
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

| xcake |  |
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

## People who use Xcake

- Bending Spoons
- Moovit

## License
This project is licensed under the terms of the MIT license. See the LICENSE file.

This project is no way affiliated with Apple Inc. This project is open source under the MIT license, which means you have full access to the source code and can modify it to fit your own needs. Xcake runs on your own computer or server, so your sensitive information will never leave your own computer. You are responsible for how you use xcake.
