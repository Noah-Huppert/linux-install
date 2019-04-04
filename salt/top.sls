base:
  '*':
    # Salt configuration
    - salt-configuration

    # Base system configuration
    - kernel
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

    # User configuration
    - zsh

    - users

    - sudoers
    - linux-install-repo
    - home-directories

    # User interface configuration
    - xorg
    - i3
    - alacritty
    - tmux
    - compton
    - dunst
    - polybar
    - rice

    # General tools configuration
    - utilities
    - flatpak
    - gpg
    - git
    - vsv

    # Development environment configuration
    - emacs
    - scripts-repo
    - salt-apply-script
    - python

    # Applications configuration
    - misc-applications
    - firefox
    - slack