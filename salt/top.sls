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

    # Applications and tools
    - xorg
    - i3
    - compton
    - dunst

    - gpg
    - git

    - alacritty
    - tmux
