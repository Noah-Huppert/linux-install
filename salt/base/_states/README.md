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
  
# Development
After making changes to any states the following command must be run:

```
sudo salt-call --local saltutil.sync_states
```
