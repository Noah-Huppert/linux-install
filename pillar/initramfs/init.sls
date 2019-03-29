{% set initramfs_file = 'void-initramfs.img' %}

initramfs:
  # Dracut configuration file directory
  dracut_config_dir: /etc/dracut.conf.d

  # XBPS triggers hook file to rebuild initramfs on kernel updates
  dracut_xbps_hook_file: /etc/kernel.d/post-install/20-dracut

  # Path information about initramfs file
  initramfs_file:
    # Name of file without directories
    file: {{ initramfs_file }}

    # Location of file without leading '/'. Required because XBPS tools run in
    # the root directory of a fake environment
    xbps_relpath: boot/efi/{{ initramfs_file }}

    # Path to file in boot partition
    boot_part_path: /{{ initramfs_file }}
