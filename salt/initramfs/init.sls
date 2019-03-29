# Configures Dracut to create an initial ram file system which supports booting
# from a LUKS container.

# Dracut configuration
{{ pillar.initramfs.dracut_config_dir }}:
  file.recurse:
    - source: salt://initramfs/dracut.conf.d
    - dir_mode: 755
    - file_mode: 755
