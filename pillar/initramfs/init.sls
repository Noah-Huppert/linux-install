{% import_yaml 'partitions/init.sls' as pillar_partitions %}
{% import_yaml 'kernel/init.sls' as pillar_kernel %}
{% set partitions = pillar_partitions['partitions'] %}
{% set kernel = pillar_kernel['kernel'] %}

initramfs:
  # Path to initramfs file relative to boot directory mount point
  file: initramfs-{{ kernel['version'] }}.img

  # Dracut configuration directory
  dracut_config_dir: /etc/dracut.conf.d
