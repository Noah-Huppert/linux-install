backlight:
  # Backlight control package
  pkg: light

  # Udev rules file which allows light tool to manage backlight without sudo
  udev_rules_file: /etc/udev/rules.d/90-backlight.rules