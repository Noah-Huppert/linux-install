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
    - internet
    - xbps-configuration
    - ntp
    - touchpad
    - audio
    - backlight
    - bluetooth

    # User configuration
    - zsh
    - docker

    - users
    - zsh-profile

    - sudoers
    - linux-install-repo
    - home-directories

    # Development environment configuration
    - emacs
    - scripts-repo
    - salt-apply-script
    - c
    - go
    - python

    # General tools configuration
    - utilities
    - flatpak
    - gpg
    - git
    - ssh
    - vsv
    - checkforupdates
    - wireguard

    # User interface configuration
    - xorg
    - i3
    - alacritty
    - tmux
    - compton
    - dunst
    - polybar
    - rice
 
    # Applications configuration
    - misc-applications
    - firefox
    - slack
    - weechat
    - discord
