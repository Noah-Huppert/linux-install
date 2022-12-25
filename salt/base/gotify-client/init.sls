# Installs gotify-client from xbps.
# src=xbps
{% for pkg in pillar['gotify_client']['xbps_gotify_client_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}


# src=python3
{% for pkg in pillar['gotify_client']['python3_gotify_client_pkgs'] %}
{{ pkg }}:
  pip.installed:
    - pip_bin: {{ pillar.python.pip3_bin }}
{% endfor %}

# Gotify Tray service
{{ pillar.gotify_client.gotify_tray_desktop_file }}:
  file.managed:
    - source: salt://gotify-client/gotify-tray.desktop