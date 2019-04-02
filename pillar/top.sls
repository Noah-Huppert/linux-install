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

    # User level configuration
    - zsh 

    - users
    - users-secret

    - sudoers
    - linux-install-repo

    # Applications and tools
    - xorg

    - gpg
    - git-secret

    - alacritty
