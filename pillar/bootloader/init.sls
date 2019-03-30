{% import_yaml 'kernel/init.sls' as pillar_kernel %}
{% set kernel = pillar_kernel['kernel'] %}

{% set check_refind_installed_dir = '/opt/check-refind-installed' %}

bootloader:
  # Name of refind package
  refind_pkg: refind

  # Linux bootloader path inside boot partition
  linux_bootloader_path: /void-vmlinuz-{{ kernel['version'] }}


  # Check refind installed script
  check_refind_installed_script: 
    directory: {{ check_refind_installed_dir }}
    file: {{ check_refind_installed_dir }}/check-refind-installed.sh
