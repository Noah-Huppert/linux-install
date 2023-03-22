partitions:
  # Boot partition
  boot: 
    # Device name
    name: /dev/nvme0n1p1

    # UUID
    uuid: EE06-934C

    # Mount point
    mountpoint: /boot

    # File system type
    filesystem_type: vfat

    # Device mount options
    mount_options: rw,relatime,codepage=437

    # Dump mount option
    mount_option_dump: 0

    # Pass mount option
    mount_option_pass: 2

  # Root partition
  root:
    # Device name
    name: /dev/nvme0n1p5

    # UUID
    uuid: 1858abc3-e456-4a2e-9843-6d1deefae127

    # Mount point
    mountpoint: /

    # File system type
    filesystem_type: ext4
