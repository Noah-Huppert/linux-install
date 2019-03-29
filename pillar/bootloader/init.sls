{% set check_refind_installed_dir = '/opt/check-refind-installed' %}

bootloader:
  # Name of refind package
  refind_pkg: refind

  # Linux bootloader path inside boot partition
  linux_bootloader_path: /void-vmlinuz


  # Check refind installed script
  check_refind_installed_script: 
    directory: {{ check_refind_installed_dir }}
    file: {{ check_refind_installed_dir }}/check-refind-installed.sh
