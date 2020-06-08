# Install and configure backlight control.

# Install
{{ pillar.backlight.pkg }}:
  pkg.latest

# Configure
{{ pillar.backlight.udev_rules_file }}:
  file.managed:
    - source: salt://backlight/90-backlight.rules
    - makedirs: True
