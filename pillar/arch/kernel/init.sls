{% set version = "6.6.5.arch1-1" %}

kernel:
  # Current version
  version: {{ version }}

  # Package which installs Kernel
  kernel_pkg: linux

  # Initramfs builder configuration
  mkinitcpio_conf: /etc/mkinitcpio.conf

  # Modprobe directory
  modprobe_dir: /etc/modprobe.d/

  # Vconsole configuration file, used during boot
  vconsole_conf_file: /etc/vconsole.conf
