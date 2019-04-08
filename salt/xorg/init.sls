# Install and configure Xorg display server and driver.

# Install
{{ pillar.xorg.package }}:
  pkg.latest

# Configure
{{ pillar.xorg.configuration_file }}:
  file.managed:
    - source: salt://xorg/configuration/xinit
    - user: noah
    - group: noah
    - mode: 744
