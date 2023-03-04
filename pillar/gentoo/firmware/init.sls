firmware:
  pkgs:
    # Firmware
    - sys-kernel/linux-firmware
    - x11-drivers/xf86-input-synaptics
    - x11-base/xorg-drivers

    # Utilities
    - sys-apps/usbutils
    - sys-apps/input-utils
    - app-misc/evtest
    - sys-apps/dmidecode

  modprobe_dir: /etc/modprobe.d/