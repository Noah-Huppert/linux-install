initramfs:
  # Name of initramfs file
  file: {{ pillar.get('partitions.boot.mountpoint') }}/initramfs-{{ pillar.get('kernel.version') }}.img

  # Dracut configuration directory
  dracut_config_dir: /etc/dracut.conf.d
