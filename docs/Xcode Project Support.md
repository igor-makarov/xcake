#Xcode Project  Support

This document describes the level of support Xcake has for the various aspects of the Xcode Project.

## Project

- Create a Project File
- Create build configurations via configurations
- Set name of project file
- Setting Class Prefix
- Setting Organization
- Including Files and Groups (Currently done via Targets)
- Including Frameworks (Currently done via Targets)
- Specify build settings via configurations
- Specify schemes (Currently only for applications via configurations - Xcode auto-creates for other types)

## Target

- Create target
- Create build configurations via configurations
- Set name of target
- Set primary language
- Set platform
- Set deployment target
- Specify device (Universal, iPad Only or iPhone Only)
- Specifying Files and Assets to include or exclude for Target
- Specifying Frameworks to include for Target
- Specify build settings via configurations
- Simple methods for creating iOS, Mac and WatchOS Applications.
- Simple methods for creating Unit Tests
- Build Phases are generated implicity and can be specified explicity for:
    - Copy Headerss
    - Shell Script

## Build Configuration

- Set name for configuration
- Specify build settings
- Set XCConfig to inherit settings from

## Scheme

- Set name for scheme
- Set build configuration for each action (Build, Launch, Archive etc.)

## Files

- Can Include Normal Files
- Can Include Bundles
- Can Include Libraries
- Can Include Localized Files
