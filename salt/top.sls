base:
  '*':
    # Base system configuration
    - kernel
    - initramfs
    - bootloader
    - fstab

    # Higher level system configuration
    - system-configuration
    - xbps-configuration
    - ntp
