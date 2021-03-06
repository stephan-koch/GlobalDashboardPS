# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Function for adding members to a group
- Function for removing members from a group
- Function for changing the name and/or the parent of a group
- Function for returning the sso url of an appliance
- Function for returning the sso url of a server hardware
- Function for returning the sso url of an enclosure
- Function for importing a server certificate
- Function for removing a server certificate
- Function for listing the configuration of the network interfaces
- Function for configuring a network interface
- Support paging (#8)
- Scriptanalyzer test

## [version 0.9.1] - 2019-08-14

### Changed

- Changed Get-OVGDResourceAlert so it supports queries for ServiceEvents

## [version 0.9.0] - 2019-04-25

### Added

- Support queries (#9)

### Changed / Breaking

- Changed Entity parameter to Id for all functions (added Entity as alias)

### Fixed

- Reworked output to fix issue with outputting a single object (#10)
- Fixed missing query for state on Get-OVGDServerHardware

## [version 0.8.0] - 2019-04-24

### Added

- Function for listing Storage pools (#4)
- Function for listing Storage volumes (#5)
- Function for listing SAN Managers (#6)
- Function for listing Managed SANs (#7)

### Changed

- Minor change to help text (server parameter) on most functions

## [version 0.7.2] - 2019-04-24

### Changed

- Output on Get-OVGDTask

## [version 0.7.1] - 2019-04-24

### Changed

- Nothing.. Skipped due to mismatch of versioning

## [version 0.7.0] - 2019-04-24

### Added

- Function for listing Tasks (#3)

### Changed / Breaking

- Renamed Resource Alerts function

## [version 0.6.0] - 2019-04-24

### Added

- Support PSCredential (#1)
- Function for listing Resource Alerts (#2)

## [version 0.5.0] - 2019-04-23

### Changed

- Output format

## [version 0.4.6] - 2019-04-23

### Changed

- Validating method variable in the Invoke-OVGDRequest function

## [version 0.4.5] - 2019-04-17

### Fixed

- Tags in manifest file

## [version 0.4.4] - 2019-04-17

### Fixed

- Specified test in pipeline

## [version 0.4.3] - 2019-04-17

### Added

- CI pipeline

## [version 0.4.2] - 2019-04-17

### Added

- Help text

## [version 0.4.1] - 2019-04-17

### Changed

- Renamed group Add-OVGDGroup to New-OVGDGroup

## [version 0.4.0] - 2019-04-17

### Added

- Pester tests

## [version 0.3.0] - 2019-03-28

### Changed

- Renamed the module manifest file to the correct name

## [version 0.2.3] - 2019-03-28

### Added

- Function for Updating an appliance
- Function for Removing an appliance

### Changed

- Adding support for contenttype in Invoke-OVGDRequest cmdlet

## [version 0.2.2] - 2019-03-27

### Added

- Function for Adding an appliance

## [version 0.2.1] - 2019-03-27

### Changed

- Fixed some syntax based on PSScriptAnalyzer tests

## [version 0.2.0] - 2019-03-27

### Added

- Added README
- Added changelog
- Module manifest

### Changed

- Moved functions to separate files

## [version 0.1.1] - 2019-03-27

### Changed

- Changed name of function that creates resource path

## [version 0.1.0] - 2019-03-25

### Added

- Initial commit of module. All contained in a single psm1 file
  - Following functions are added:
    - Connect-OVGD
    - New-OVGDSessionKey
    - Disconnect-OVGD
    - Remove-OVGDSessionKey
    - Get-OVGDAppliance
    - Get-OVGDCertificate
    - Get-OVGDConvergedSystem
    - Get-OVGDEnclosure
    - Get-OVGDGroup
    - Add-OVGDGroup
    - Remove-OVGDGroup
    - Get-OVGDGroupMember
    - Get-OVGDServerHardware
    - Get-OVGDServerProfile
    - Get-OVGDServerProfileTemplate
    - Get-OVGDStorageSystem
    - BuildResource (private function)
    - Invoke-OVGDRequest (private function)
    - Set-InsecureSSL (private function)