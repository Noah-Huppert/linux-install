{% set version = "6.4.2" %}

kernel:
  # Directory where source code lives
  src_dir: /usr/src

  # Directory where current Linux version should be linked
  main_dir: /usr/src/linux

  # Make configuration file location
  make_config_paths:
    - /usr/src/linux/.config
    - /etc/kernels/kernel-config-{{ version }}-gentoo-x86_64


  # The source package name
  src_pkg: sys-kernel/gentoo-sources

  # Tool packages
  tool_pkgs:
    - app-admin/eclean-kernel
    - sys-kernel/gentoo-kernel

  # Current version
  version: {{ version }}

  # Modprobe directory
  modprobe_dir: /etc/modprobe.d/

  # Genkernel (kernel and initramfs build tool) configuration file
  # Used when building own kernel from source
  genkernel_conf_file: /etc/genkernel.conf

  # Dracut (initramfs tool) configuration file
  # Used when using a dist kernel
  dracut_conf_file_dir: /etc/dracut.conf.d/

  # Kernel config file
  kernel_config_file: /etc/portage/savedconfig/sys-kernel/gentoo-kernel

  # Vconsole configuration file, used during boot
  vconsole_conf_file: /etc/vconsole.conf
