v0.5.2
======
- Updates `xcake init` for new project syntax.
- Adds shorthand build configuration syntax for projects which only contain one debug or release configuration.

v0.5.1
======
- Tweaks DSL so it is easier to access the project properties via the `project` method.

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
- Correctly containing `.xcdatamodeld` files to a project, rather than the
  internal `.xcdatamodel`.

v0.4.2
======
- Correctly adds `.xcdatamodel` files to a project.

v0.4.1
======
- Error message for missing `Cakefile` is more understandable.

v0.4.0
======
- Adds ability to easily specify preprocessor definitions.
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
  works with existing build   scripts.
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
- Removes references to "build_configurations" to just "configuration".
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
