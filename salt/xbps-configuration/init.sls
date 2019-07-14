# Configures XBPS.

# XBPS repository configuration
{{ pillar.xbps_configuration.repository.file }}:
  file.managed:
    - source: salt://xbps-configuration/00-repository-main.conf
    - template: jinja

# Main XBPS configuration
{{ pillar.xbps_configuration.main_configuration_file }}:
  file.managed:
    - source: salt://xbps-configuration/xbps.conf
    - template: jinja

# Install non-free repository
{{ pillar.xbps_configuration.non_free_pkg }}:
  pkg.latest

# Repository packages
{% for pkg in pillar['xbps_configuration']['repository']['pkgs'] %}
{{ pkg }}:
  pkg.latest
{% endfor %}
