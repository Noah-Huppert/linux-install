# States
Custom Salt states.

# Table Of Contents
- [Overview](#overview)
- [Development](#development)

# Overview
Provides several custom Salt states:

- `aurpkg`: Manages AUR packages from the Arch Linux auxiliary package repository
  - `check_installed(name: str, pkgs: Optional[List[str]])`: Checks the specified package(s) are installed
  - `installed(name: str, pkgs: Optional[List[str]])`: Ensures the specified package(s)s are installed
- `user_service`: Manages services run in a user's session
  - `enabled(name: str, user: str, start: bool)`: Enables a service for a user, if `start` given then the service is also started
- `multipkg`: Installs packages using multiple different package manager Salt states (ex., `pkg` and `aurpkg`)
  - `installed(name: str, pkgs: List[PkgDef])`: Installs packages specified by package definitions in `pkgs`, these definitions must be one of the following formats:
      - List of dictionaries with only one key. Where the key is the name of the Salt state used to install the package named by value. The value can either be a single package or a list of packages. In this list a dictionary key can only appear once
      - List of strings or single string. The default `pkg` state is used to install these packages
  Packages is a list of dictionaries where each only has one key, being the Salt state to install packages in the value via
  
# Development
After making changes to any states the following command must be run:

```
sudo salt-call --local saltutil.sync_states
```
