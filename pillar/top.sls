base:
  '*':
    # Base system configuration
    - partitions
    - kernel
    - cleanup-kernel
    - initramfs
    - bootloader
    - fstab

    # Higher level system configuration
    - system-configuration
    - hostname
    - internet
    - internet-secret
    - xbps-configuration
    - ntp
    - touchpad
    - audio
    - backlight

    # User level configuration
    - zsh 
    - docker

    - users
    - users-secret
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
    - git-secret
    - ssh
    - vsv
    - checkforupdates

    # User interface configuration
    - xorg
    - i3
    - tmux
    - alacritty
    - compton
    - dunst
    - polybar
    - rice
 
    # Applications configurtion
    - misc-applications
    - firefox
    - slack
    - weechat
    - discord
