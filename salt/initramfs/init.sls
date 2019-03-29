# Configures Dracut to create an initial ram file system which supports booting
# from a LUKS container.

# Dracut configuration
{{ pillar.initramfs.dracut_config_dir }}:
  file.recurse:
    - source: salt://initramfs/dracut.conf.d
    - dir_mode: 755
    - file_mode: 755

# Configure XBPS trigger to rebuild initramfs with custom out path
{{ pillar.initramfs.dracut_xbps_hook_file }}:
  file.managed:
    - source: salt://initramfs/kernel.d/post-install/20-dracut
    - template: jinja
