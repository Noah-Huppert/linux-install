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
    - xbps-configuration
    - ntp

    # User level configuration
    - users
