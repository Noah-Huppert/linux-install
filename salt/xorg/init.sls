# Install and configure Xorg display server and driver.

# Install
{{ pillar.xorg.package }}:
  pkg.installed
