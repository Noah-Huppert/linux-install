base:
  '*':
    # Salt configuration
    - salt-configuration

    # Base system configuration
    - kernel
    - cleanup-kernel
    - exfat
    - initramfs
    - bootloader
    - fstab

    # Higher level system configuration
    - system-configuration
    - hostname
    - syslog
    - internet
    - xbps-configuration
    - ntp
    - touchpad
    - audio
    - backlight
    - bluetooth
    - fingerprint-reader
    - local-dns
    - external-display
    - power-management
    - printers

    # User configuration
    - zsh

    - users
    - zsh-profile

    - sudoers
    - linux-install-repo
    - home-directories

    # Development environment configuration
    - build-deps
    - emacs
    - tmux
    - scripts-repo
    - salt-apply-script
    - c
    - cmake
    - pkg-config
    - go
    - python
    - elixir
    - nodejs
    - rust
    - aws-cli
    - digitalocean-cli
    - google-cloud-sdk
    - red-hat-vpn
    - aws-key-pairs
    - openshift-client
    - android-sdk
    - flutter
    - argo
    - ngrok
    - operator-sdk
    - mbed
    - particle
    - dfu-util
    - kustomize
    - gatsby-cli
    - xlibs
    - typescript

    # General tools configuration
    - utilities
    - flatpak
    - gpg
    - git
    - mercurial
    - ssh
    - vsv
    - checkforupdates
    - wireguard
#    - lock-script
    - kube-namespace
    - network-utils
    - vault
    - containers
    - freetype
    - expat
    - ncdu
    - software-defined-radio

    # User interface configuration
    - xorg
    - i3
    - alacritty
    - compton
    - dunst
    - polybar
    - rice
    - fonts
 
    # Applications configuration
    - misc-applications
    - firefox
    - slack
    - weechat
    - blender
    - logisim
    - wireshark
    - tor
    - steam
    - chrome
    - cool-retro-term
    - open-broadcaster-software
    - libre-office
    - minecraft
    - pirate-get

    # Applications which must be manually built and installed
    - manual-void-pkgs
