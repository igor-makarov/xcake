v0.6.23
=======
- Adds support for Localized Files.
- Swift is no-longer optimized for debug configurations when Xcake is ran with
older versions of Xcodeproj.

v0.6.22
=======
- Fixes crash with `after_save` hook.

v0.6.21
=======
- Improved UI Output.
- Fixes crash when no XCConfig is set.

v0.6.20
=======
- When adding a file to a group, Xcode will now open the correct folder.
- Adds support for adding third-party frameworks.
- Fixes `all_configurations` not returning all configurations when using implicit configurations.
- Names of the implicit configurations match the default configurations for Xcode projects.
- Fixes out of date documentation.
- Fixes typos and out of date API used in `xcake init` template.
- Removes dependency on `Molinillo` for internal dependency resolution.
- Fixes issues with adding XCConfig.

v0.6.19
=======
- Uses the reccomended code signing settings from Apple.

v0.6.18
=======
- Fixes cases where xcode would complain about embedded products weren't
signed by the same profile.

v0.6.17
=======
- Fixes issues installing later versions of Xcake with dependencies that
required a version of Claide before version 1.0.

v0.6.16
=======
- Fixes issue where Xcodeproj created release configurations which used the
developer code signing certificate rather than the distribution certificate.

v0.6.15
=======
- Support Xcodeproj 1.0's new Plist module.

v0.6.14
=======
- Updates Claide dependency.

v0.6.13
=======
- Updates Xcodeproj dependency.

v0.6.12
=======
- Fixes issues when resolving project with implicit configurations.

v0.6.11
=======
- Fixes issues with system frameworks with inherited configurations.

v0.6.10
=======
- Fixes race-condition where configurations weren't setup.

v0.6.9
======
- Fixes project configurations not inherited by targets.

v0.6.8
======
- Improvements to setting build settings on all configurations (Thanks to @therealbnut).

v0.6.7
======
- Fixes issue where `agvtool` command line tool failed to find plist with the default value used for the `INFOPLIST_FILE` build setting.

v0.6.6
======
- Fixes issue where `agvtool` command line tool failed to understand preprocessor directives used with the default value used for the `INFOPLIST_FILE` build setting.

v0.6.5
======
- Fixes bug with generating Xcode Project without specifying XCConfig files.

v0.6.4
======
- Fixes error when installing XCConfig files.

v0.6.3
======
- Adds support for adding system and static libraries (Thanks to @nodepad).
- Adds support for folder references (Thanks to @nodepad).
- Adds support for XCConfig Files (Thanks to @colinta).
- Documentation updated to explain how to set up a unit test target (Thanks to @maximkhatskevich).

v0.6.2
======
- Fixes bug where certain file installers fail to register and could cause issues with adding certain files to the Xcode project.

v0.6.1
======
- Reduces gem file-size

v0.6.0
======
- Infers build phases for the apple watch.
- Fixes bug where configurations lacked a name when using shorthand syntax. (Thanks to @colinta).
- Adds support for custom script build phases (Thanks to @colinta).

v0.5.3
======
- Updates `xcake bake` to the more generic `xcake make` (Thanks to @roger-tan).

v0.5.2
======
- Updates `xcake init` for new project syntax.
- Adds shorthand build configuration syntax for projects which contain one debug or release configuration (Thanks to @colinta).

v0.5.1
======
- Tweaks DSL so it's easier to access the project properties via the `project` method.

v0.5.0
======
- Introduces `xcake init` command to setup an example Cakefile for you.
- To turn a Cakefile into a project you now run `xcake bake`.
- Simplified DSL, you no longer have to declare the project. Check the documentation for details.
- Adds support for Claide and Xcake Plugins.

v0.4.8
======
- The type property for a target now accepts a raw UTI.

v0.4.7
======
- Sets correct configurations for `analyse` and `archive` action for schemes.

v0.4.6
======
- Sets correct configurations for each action for schemes.

v0.4.5
======
- Correctly configures schemes for Applications; It should now be possible to
  run, profile, test and analyse out of the box.

v0.4.4
======
- Correctly registers `.xcdatamodeld` build phase generator.

v0.4.3
======
- Correctly adds containing `.xcdatamodeld` files to a project, rather than the
  internal `.xcdatamodel`.

v0.4.2
======
- Correctly adds `.xcdatamodel` files to a project.

v0.4.1
======
- Error message for missing `Cakefile` is more understandable.

v0.4.0
======
- Adds ability to specify preprocessor definitions.
- Adds shortcuts for specifying product bundle identifier.

v0.3.1
======
- Adds Hook system, starting with "after_save" hook for when project is saved.
- Adds ability to specify array of files to include or exclude.

v0.3.0
======
- Simplified Watch OS target syntax.
- Fixes issue with `--version` not working for all installations.

v0.2.0
======
- Now adds `--version` flag to command line, to allow you to find out Xcake's
  version.
- Brings naming of default build configurations closer to Xcode's, so that it
  works with existing build scripts.
- Adds support for Watch OS 2 Applications.

v0.1.9
======
- Updates documentation for tvOS and Watch OS support.

v0.1.8
======
- Add tvOS and Watch OS support (Thanks to @petester42).

v0.1.7
======
- Adds ability to set Project Class Prefix and Organization.

v0.1.6
======
- Fixed crash with unit tests.
- Added documentation for Configuration syntax.

v0.1.5
======
- Added documentation for Target syntax.

v0.1.4
======
- Removes references to "build_configurations" to "configuration".
  to make syntax shorter and to reflect the fact it's an abstraction
  and not directly a Xcode build configuration.

v0.1.3
======
- Reverts to an older GemSpec to fix installation issues.
- Adds initial Getting Started documentation.

v0.1.2
======
- Adds dependency information for Ruby and RubyGems versions.

v0.1.1
======
- Updated README instructions.
- General tidy up of code.

v0.1.0
======
- Initial Release.
