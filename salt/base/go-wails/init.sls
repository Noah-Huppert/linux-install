# Installs go from xbps.
# src=xbps
{% for user in pillar['users']['users'].values() %}
{% for pkg in pillar['go-wails']['golang_go-wails_pkgs'] %}
install_{{ user['name'] }}:
  cmd.run:
    - name: go install {{ pkg['url'] }}
    - runas: {{ user['name'] }}
    - unless: which {{ pkg['bin'] }}
{% endfor %}
{% endfor %}