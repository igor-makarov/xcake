# Xcake

[![Twitter: @jcampbell_05](https://img.shields.io/badge/contact-@jcampbell_05-blue.svg?style=flat)](https://twitter.com/jcampbell_05)
[![License](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/fastlane/fastlane/blob/master/LICENSE)

###Xcode Projects made a piece of cake.

You describe your project in a simple text file: your `Cakefile`. 
Xcake creates your project based on this including importing all of your file and creating groups
to match the file hiearchy.

This is perfect for working in teams or with cocoapods as it reduces conflicts,
makes it easy to modify settings and allows you to create a clean project anytime you need to.

Get in contact with the developer on Twitter: [@jcampbell_05](https://twitter.com/jcampbell_05)


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

## Need help?
Please submit an issue on GitHub and provide information about your setup

## Roadmap 

## License
This project is licensed under the terms of the MIT license. See the LICENSE file.

This project is no way affiliated with Apple Inc. This project is open source under the MIT license, which means you have full access to the source code and can modify it to fit your own needs. Xcake runs on your own computer or server, so your sensitive information will never leave your own computer. You are responsible for how you use xcake.
