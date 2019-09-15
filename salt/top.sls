base:
  '*':
    # Salt configuration
    - salt-configuration

    # Base system configuration
    - kernel
    - cleanup-kernel
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
    - red-hat-vpn
    - aws-key-pairs
    - openshift-client
    - android-sdk
    - flutter
    - argo
    - ngrok
    - operator-sdk
    - ncdu

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
    - net-tools
    - vault
    - containers
    - freetype
    - expat

    # User interface configuration
    - xorg
    - i3
    - alacritty
    - tmux
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
    - discord
    - blender
