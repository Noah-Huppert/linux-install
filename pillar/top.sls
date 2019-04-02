base:
  '*':
    # Base system configuration
    - partitions
    - kernel
    - initramfs
    - bootloader
    - fstab

    # Higher level system configuration
    - xbps-configuration
