# Installs qBittorrent
{% for pkg in pillar['qbittorrent']['pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
