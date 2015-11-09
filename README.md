# Xcake

[![Twitter: @jcampbell_05](https://img.shields.io/badge/contact-@jcampbell_05-blue.svg?style=flat)](https://twitter.com/jcampbell_05)
[![License](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/fastlane/fastlane/blob/master/LICENSE)

######*Xcake* lets you describe your xcode project using a simple DSL syntax. This reduces conflicts, makes it easy to modify settings and allows you to create a clean project everytime you need to.

Get in contact with the developer on Twitter: [@jcampbell_05](https://twitter.com/jcampbell_05)

-------
<p align="center">
<!--    <a href="#features">Features</a> &bull;-->
<!--    <a href="#installation">Installation</a> &bull;-->
<!--    <a href="#quick-start">Quick Start</a> &bull;-->
<!--    <a href="#examples">Example Setups</a> &bull; -->
<!--    <a href="https://github.com/fastlane/fastlane/tree/master/docs">Documentation</a> &bull; -->
<!--    <a href="#need-help">Need help?</a>-->
</p>

-------

## Features

<!--Why should you have to remember complicated commands and parameters?-->

<!--Store your configuration in a text file to easily test, build, and deploy from _any_ computer.-->

<!--[Take a look at how Wikipedia and Product Hunt use `fastlane`](https://github.com/fastlane/examples).-->

<!--Define different environments (`lanes`) in your `Fastfile`: Examples are: `appstore`, `beta` and `test`.-->

<!--You define a `lane` like this (more details about the commands in the [Actions](https://github.com/fastlane/fastlane/blob/master/docs/Actions.md) documentation):-->

<!--```ruby-->
<!--lane :appstore do-->
<!--  increment_build_number-->
<!--  cocoapods-->
<!--  xctool-->
<!--  snapshot-->
<!--  sigh-->
<!--  deliver-->
<!--  sh "./customScript.sh"-->

<!--  slack-->
<!--end-->
<!--```-->

<!--To launch the `appstore` lane, just run:-->

<!--```sh-->
<!--fastlane appstore-->
<!--```-->

<!--              |  fastlane-->
<!----------------------------|-------------------------------------------------------------->
<!--:sparkles: | Connect all iOS build tools into one workflow (both `fastlane` tools and third party tools)-->
<!--:monorail: | Define different `deployment lanes` for App Store deployment, beta builds or testing-->
<!--:ship: | Deploy from any computer, including a CI-server-->
<!--:wrench: | Extend and customise the functionality -->
<!--:thought_balloon: | Never remember any difficult commands, just `fastlane`-->
<!--:tophat: | Easy setup assistant to get started in a few minutes-->
<!--:email: | Automatically pass on information from one build step to another (e.g. path to the `ipa` file)-->
<!--:page_with_curl: | Store **everything** in git. Never again lookup the build commands in the `Jenkins` configs-->
<!--:rocket: | Saves you **hours** for every app update you release-->
<!--:pencil2: | Very flexible configuration using a fully customisable `Fastfile`-->
<!--:mountain_cableway: | Implement a fully working Continuous Delivery process-->
<!--:ghost: | [Jenkins Integration](https://github.com/fastlane/fastlane/blob/master/docs/Jenkins.md): Show the output directly in the Jenkins test results-->
<!--:book: | Automatically generate a markdown documentation of your lane config-->
<!--:hatching_chick: | Over 90 built-in integrations available-->
<!--:computer: | Support for both iOS and Mac OS apps-->
<!--:octocat: | Full git and mercurial support-->


<!--###### Take a look at the [fastlane website](https://fastlane.tools) for more information about why and when to use `fastlane`.-->

<!--##### Like this tool? [Be the first to know about updates and new fastlane tools](https://tinyletter.com/krausefx).-->

## Installation

<!--I recommend following the [fastlane guide](https://github.com/fastlane/fastlane/blob/master/docs/Guide.md) to get started.-->

<!--    sudo gem install fastlane --verbose-->

<!--Make sure, you have the latest version of the Xcode command line tools installed:-->

<!--    xcode-select --install-->

<!--If you experience slow launch times of fastlane, try running-->

<!--    gem cleanup-->

<!--to clean up outdated gems.-->

<!--System Requirements: `fastlane` requires Mac OS X or Linux with Ruby 2.0.0 or above.-->


<!--If you want to take a look at a project, already using `fastlane`, check out the [fastlane-examples](https://github.com/fastlane/examples) with `fastlane` setups by Wikipedia, Product Hunt, MindNode and more.-->

## Quick Start

<!--The setup assistant will create all the necessary files for you, using the existing app metadata from iTunes Connect.-->

<!--- ```cd [your_project_folder]```-->
<!--- ```fastlane init```-->
<!--- Follow the setup assistant, which will set up ```fastlane``` for you-->
<!--- Further customise the ```Fastfile``` with [actions](https://github.com/fastlane/fastlane/blob/master/docs/Actions.md).-->

<!--For more details, please follow the [fastlane guide](https://github.com/fastlane/fastlane/blob/master/docs/Guide.md) or [documentation](https://github.com/fastlane/fastlane/tree/master/docs).-->

<!--There are also 2 Japanese fastlane guides available: [qiita](http://qiita.com/gin0606/items/162d756dfda7b84e97d4) and [mercari](http://tech.mercari.com/entry/2015/07/13/143000)-->

<!--## Available commands-->

<!--Usually you'll use fastlane by triggering individual lanes:-->

<!--    fastlane [lane_name]-->

<!--#### Other commands-->

<!--- `fastlane actions`: List all available `fastlane` actions-->
<!--- `fastlane action [action_name]`: Shows a more detailed description of an action-->
<!--- `fastlane lanes`: Lists all available lanes with description-->
<!--- `fastlane list`: Lists all available lanes without description-->
<!--- `fastlane docs`: Generates a markdown based documentation of all your lanes-->
<!--- `fastlane new_action`: Create a new action (integration) for fastlane  -->

<!--## Examples-->

<!--See how [Wikipedia](https://github.com/fastlane/examples#wikipedia-by-wikimedia-foundation), [Product Hunt](https://github.com/fastlane/examples#product-hunt) and [MindNode](https://github.com/fastlane/examples#mindnode) use `fastlane` to automate their iOS submission process.-->

<!--## [`fastlane`](https://fastlane.tools) Toolchain-->

<!--`fastlane` is designed to make your life easier by bringing together all `fastlane` tools-->

<!--- [`deliver`](https://github.com/fastlane/deliver): Upload screenshots, metadata and your app to the App Store-->
<!--- [`snapshot`](https://github.com/fastlane/snapshot): Automate taking localized screenshots of your iOS app on every device-->
<!--- [`frameit`](https://github.com/fastlane/frameit): Quickly put your screenshots into the right device frames-->
<!--- [`PEM`](https://github.com/fastlane/pem): Automatically generate and renew your push notification profiles-->
<!--- [`sigh`](https://github.com/fastlane/sigh): Because you would rather spend your time building stuff than fighting provisioning-->
<!--- [`produce`](https://github.com/fastlane/produce): Create new iOS apps on iTunes Connect and Dev Portal using the command line-->
<!--- [`cert`](https://github.com/fastlane/cert): Automatically create and maintain iOS code signing certificates-->
<!--- [`codes`](https://github.com/fastlane/codes): Create promo codes for iOS Apps using the command line-->
<!--- [`spaceship`](https://github.com/fastlane/spaceship): Ruby library to access the Apple Dev Center and iTunes Connect-->
<!--- [`pilot`](https://github.com/fastlane/pilot): The best way to manage your TestFlight testers and builds from your terminal-->
<!--- [`boarding`](https://github.com/fastlane/boarding): The easiest way to invite your TestFlight beta testers -->
<!--- [`gym`](https://github.com/fastlane/gym): Building your iOS apps has never been easier-->

## Need help?
Please submit an issue on GitHub and provide information about your setup

<!--## Special Thanks-->

<!--Thanks to all [contributors](https://github.com/fastlane/fastlane/graphs/contributors) for extending and improving `fastlane`. Check out the project pages of the other tools for more sponsors and contributors.-->

## License
This project is licensed under the terms of the MIT license. See the LICENSE file.

This project is no way affiliated with Apple Inc. This project is open source under the MIT license, which means you have full access to the source code and can modify it to fit your own needs. Xcake runs on your own computer or server, so your sensitive information will never leave your own computer. You are responsible for how you use xcake.


<!--![CocoaPods Logo](https://raw.github.com/CocoaPods/shared_resources/master/assets/cocoapods-banner-readme.png)-->

<!--### CocoaPods: The Cocoa dependency manager-->

<!--[![Build Status](http://img.shields.io/travis/CocoaPods/CocoaPods/master.svg?style=flat)](https://travis-ci.org/CocoaPods/CocoaPods)-->
<!--[![Gem Version](http://img.shields.io/gem/v/cocoapods.svg?style=flat)](http://badge.fury.io/rb/cocoapods)-->
<!--[![Code Climate](http://img.shields.io/codeclimate/github/CocoaPods/CocoaPods.svg?style=flat)](https://codeclimate.com/github/CocoaPods/CocoaPods)-->

<!--CocoaPods manages dependencies for your Xcode projects.-->

<!--You specify the dependencies for your project in a simple text file: your `Podfile`. -->
<!--CocoaPods recursively resolves dependencies between libraries, fetches -->
<!--source code for all dependencies, and creates and maintains an Xcode -->
<!--workspace to build your project.-->

<!--Installing and updating CocoaPods is very easy. Don't miss the [Installation-->
<!--guide](http://guides.cocoapods.org/using/getting-started.html#installation) and the-->
<!--[Getting started guide](https://guides.cocoapods.org/using/getting-started.html).-->

<!--## Project Goals-->

<!--CocoaPods aims to improve the engagement with, and discoverability -->
<!--of, third party open-source Cocoa libraries. These-->
<!--project goals influence and drive the design of CocoaPods:-->

<!--- Create and share libraries, and use them in your own projects,-->
<!--  without creating extra work for library authors. Integrate-->
<!--  non-CocoaPods libraries and hack on your own fork of any-->
<!--  CocoaPods library with a simple transparent `Podspec` standard.-->
<!--- Allow library authors to structure their libraries however they like.-->
<!--- Save time for library authors by automating a lot of Xcode work not -->
<!--  related to their libraries' functionality.-->
<!--- Support any source management system. (Currently supported are `git`, -->
<!--  `svn`, `mercurial`, `bazaar`, and various types of archives downloaded over HTTP.)-->
<!--- Promote a culture of distributed collaboration on pods, but also provide-->
<!--  features only possible with a centralised solution to foster a community.-->
<!--- Build tools on top of the core Cocoa development system, including those -->
<!--  typically deployed to other operating systems, such as web-services.-->
<!--- Provide opinionated and automated integration, but make it completely-->
<!--  optional. You may manually integrate your CocoaPods dependencies-->
<!--  into your Xcode project as you see fit, with or without a workspace.-->
<!--- Solve everyday problems for Cocoa and Xcode developers.-->

<!--## Sponsors-->

<!--Lovingly sponsored by a collection of companies, see the footer of [CocoaPods.org](https://cocoapods.org) for an up-to-date list. -->

<!--## Collaborate-->

<!--All CocoaPods development happens on GitHub. Contributions make for good karma and-->
<!--we [welcome new](https://blog.cocoapods.org/starting-open-source/) contributors with joy. We take contributors seriously, and thus have a -->
<!--contributor [code of conduct](CODE_OF_CONDUCT.md).-->

<!--## Links-->

<!--| Link | Description |-->
<!--| :----- | :------ |-->
<!--[CocoaPods.org](https://cocoapods.org/) | Homepage and search for Pods.-->
<!--[@CocoaPods](https://twitter.com/CocoaPods) | Follow CocoaPods on Twitter to stay up to date.-->
<!--[Blog](https://blog.cocoapods.org) | The CocoaPods blog.-->
<!--[Mailing List](http://groups.google.com/group/cocoapods) | Feel free to ask any kind of question.-->
<!--[Guides](https://guides.cocoapods.org) | Everything you want to know about CocoaPods.-->
<!--[Changelog](https://github.com/CocoaPods/CocoaPods/blob/master/CHANGELOG.md) | See the changes introduced in each CocoaPods version.-->
<!--[New Pods RSS](https://feeds.cocoapods.org/new-pods.rss) | Don't miss any new Pods.-->
<!--[Code of Conduct](CODE_OF_CONDUCT.md) | Find out the standards we hold ourselves to.-->

<!--## Projects-->

<!--CocoaPods is composed of the following projects:-->

<!--| Status | Project | Description | Info |-->
<!--| :----- | :------ | :--- | :--- |-->
<!--| [![Build Status](http://img.shields.io/travis/CocoaPods/CocoaPods/master.svg?style=flat)](http://travis-ci.org/CocoaPods/CocoaPods) | [CocoaPods](https://github.com/CocoaPods/CocoaPods) | The CocoaPods command line tool. | [guides](https://guides.cocoapods.org)-->
<!--| [![Build Status](http://img.shields.io/travis/CocoaPods/Core/master.svg?style=flat)](http://travis-ci.org/CocoaPods/Core) | [CocoaPods Core](https://github.com/CocoaPods/Core) | Support for working with specifications and podfiles. | [docs](http://docs.cocoapods.org/cocoapods_core)-->
<!--| [![Build Status](http://img.shields.io/travis/CocoaPods/cocoapods-downloader/master.svg?style=flat)](http://travis-ci.org/CocoaPods/cocoapods-downloader) |[CocoaPods Downloader](https://github.com/CocoaPods/cocoapods-downloader) |  Downloaders for various source types. |  [docs](http://docs.cocoapods.org/cocoapods_downloader/index.html)-->
<!--| [![Build Status](http://img.shields.io/travis/CocoaPods/Xcodeproj/master.svg?style=flat)](https://travis-ci.org/CocoaPods/Xcodeproj) | [Xcodeproj](https://github.com/CocoaPods/Xcodeproj) | Create and modify Xcode projects from Ruby. |  [docs](http://docs.cocoapods.org/xcodeproj/index.html)-->
<!--| [![Build Status](http://img.shields.io/travis/CocoaPods/CLAide/master.svg?style=flat)](https://travis-ci.org/CocoaPods/CLAide) | [CLAide](https://github.com/CocoaPods/CLAide) | A small command-line interface framework.  | [docs](http://docs.cocoapods.org/claide/index.html)-->
<!--| [![Build Status](http://img.shields.io/travis/CocoaPods/Molinillo/master.svg?style=flat)](https://travis-ci.org/CocoaPods/Molinillo) | [Molinillo](https://github.com/CocoaPods/Molinillo) | A powerful generic dependency resolver.  | [docs](http://www.rubydoc.info/gems/molinillo)-->
<!--|  | [Master Repo ](https://github.com/CocoaPods/Specs) | Master repository of specifications. | [guide](http://docs.cocoapods.org/guides/contributing_to_the_master_repo.html)-->

