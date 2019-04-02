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
    - xbps-configuration
    - ntp

    # User level configuration
    - zsh 

    - users
    - users-secret

    - sudoers
