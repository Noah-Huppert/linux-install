# Installs ntfs-3g from xbps.
# src=SRC
{% for pkg in pillar['ntfs']['xbps_ntfs_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
