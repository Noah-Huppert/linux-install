base:
  '*':
    # Base system configuration
    - partitions
    - kernel
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

    - users
    - users-secret

    - sudoers
    - linux-install-repo
    - home-directories

    # Development environment configuration
    - c
    - emacs
    - scripts-repo
    - salt-apply-script
    - go
    - python

    # General tools configuration
    - utilities
    - flatpak
    - gpg
    - git-secret
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
