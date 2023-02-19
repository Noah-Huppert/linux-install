{% import_yaml 'kernel/init.sls' as pillar_kernel %}
{% set kernel = pillar_kernel['kernel'] %}

initramfs:
  # Path to initramfs file relative to boot directory mount point
  file: /initramfs-{{ kernel['version'] }}-gentoo-x86_64.img