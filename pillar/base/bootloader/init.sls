{% import_yaml 'partitions/init.sls' as pillar_partitions %}
{% set partitions = pillar_partitions['partitions'] %}

{% set check_refind_installed_dir = '/opt/check-refind-installed' %}
{% set refind_dir = partitions['boot']['mountpoint'] + '/EFI/refind' %}

bootloader:
  # Refind configuration
  refind:
    # Package
    pkg: ""

    # Directory in boot partition, relative to root
    directory: {{ refind_dir }}

    # Configuration file in boot partition, relative to root
    config_file: {{ refind_dir }}/refind.conf

    # Kernel options file
    kernel_opts_file: /boot/refind_linux.conf


  # Linux bootloader path relative to boot loader mount point
  linux_bootloader_file: null


  # Check refind installed script
  check_refind_installed_script: 
    # Directory to install
    directory: {{ check_refind_installed_dir }}

    # Script
    file: {{ check_refind_installed_dir }}/check-refind-installed.sh

  # Run check refind installed script
  run_check_refind_installed_script:
    # Script
    file: {{ check_refind_installed_dir }}/run-check-refind-installed.sh
