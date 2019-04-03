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
    - rice

    - gpg
    - git

    - alacritty
    - tmux
    - utilities

    - firefox
