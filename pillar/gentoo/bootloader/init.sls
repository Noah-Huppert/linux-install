{% import_yaml 'kernel/init.sls' as pillar_kernel %}
{% set kernel = pillar_kernel['kernel'] %}

bootloader:
  refind:
    pkg: sys-boot/refind

  linux_bootloader_file: /vmlinuz-{{ kernel['version'] }}-gentoo-x86_64
