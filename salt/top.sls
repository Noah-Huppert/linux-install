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

    # User configuration
    - zsh

    - users

    - sudoers
    - linux-install-repo
    - home-directories

    # Applications and tools
    - xorg
    - i3
    - compton
    - dunst
    - polybar
    - rice

    - alacritty
    - tmux
    - utilities

    - gpg
    - git
    - vsv
    - emacs

    - misc-applications
    - firefox
