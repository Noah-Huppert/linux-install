partitions:
  boot: 
    name: /dev/nvme0n1p1
    uuid: EE06-934C
    mountpoint: /boot
    filesystem_type: vfat
    mount_options:
      - rw
      - relatime
      - codepage=437
    mount_option_dump: 0
    mount_option_pass: 2
  root:
    name: /dev/nvme0n1p5
    uuid: dba54434-b184-4e89-800d-299fe57165d4
    mountpoint: /
    filesystem_type: ext4
