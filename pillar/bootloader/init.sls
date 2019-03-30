{% import_yaml 'kernel/init.sls' as pillar_kernel %}
{% import_yaml 'partitions/init.sls' as pillar_partitions %}
{% set kernel = pillar_kernel['kernel'] %}
{% set partitions = pillar_partitions['partitions'] %}

{% set check_refind_installed_dir = '/opt/check-refind-installed' %}

bootloader:
  # Name of refind package
  refind:
    pkg: refind
    directory: {{ partitions['boot']['mountpoint'] }}/EFI/refind


  # Linux bootloader path inside boot partition
  linux_bootloader_path: /void-vmlinuz-{{ kernel['version'] }}


  # Check refind installed script
  check_refind_installed_script: 
    directory: {{ check_refind_installed_dir }}
    file: {{ check_refind_installed_dir }}/check-refind-installed.sh

  # Run check refind installed script
  run_check_refind_installed_script:
    file: {{ check_refind_installed_dir }}/run-check-refind-installed.sh
