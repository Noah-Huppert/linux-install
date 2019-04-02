base:
  '*':
    # Base system configuration
    - kernel
    - initramfs
    - bootloader
    - fstab

    # Higher level system configuration
    - xbps-configuration
