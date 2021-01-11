funkyboy:
  '*':
    # Salt configuration
    - salt-configuration

    # Base system configuration
    - kernel
    - cleanup-kernel

    # Higher level system configuration
    - system-configuration
    - hostname
    - syslog
    - xbps-configuration
    - ntp
    - local-dns

    # User configuration
    - bash
    - zsh

    - users
    - shell-profile

    - sudoers
    - linux-install-repo
    - home-directories
    - user-services

    # Development environment configuration
    - build-deps
    - emacs
    - scripts-repo
    - salt-apply-script
    - c
    - cmake
    - pkg-config

    # General tools configuration
    - xtools
    - gpg
    - git
    - ssh
    - vsv
    - network-utils
    - containers
    - ncdu
    - sl
