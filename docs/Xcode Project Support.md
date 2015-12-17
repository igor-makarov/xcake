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
- - Create build configurations via configurations
- Set name of target
- Set primary language
- Set platform
- Set deployment target
- Specify device (Universal, iPad Only or iPhone Only)
- Specifying Files and Assets to include for Target
- Specifying Frameworks to include for Target
- Specify build settings via configurations
- Simple methods for creating iOS, Mac and WatchOS Applications.
- Simple methods for creating Unit Tests

## Configuration

- Set name for configuration (Used for name of build configuration created)
- Specify build settings
- Used to create build configuration for project and targets.
- Used to create schemes for applications

## Scheme

- No manual control. For Application targets, xcake creates them based on the configurations for those targets (i.e "myApp-Debug". "myApp-Release")
- Xcode auto-creates them currently for other target types.
