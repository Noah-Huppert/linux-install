{% set version = '5.0.3_1' %}

kernel:
  # Name of linux package without version
  pkg: linux

  # Kernel package version
  version: 5.0.3_1

  initramfs_file: {{ pillar.get('partitions.boot.mountpoint') }}/initramfs-{{ version }}.img
#  # Information about initramfs file 
#  initramfs_file:
#    # Prefix before version in file name
#    prefix: initramfs
#
#    # File extension with dot
#    ext: .img
