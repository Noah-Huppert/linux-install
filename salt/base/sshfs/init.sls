# Installs fuse-sshfs from xbps.
# src=SRC
{% for pkg in pillar['sshfs']['xbps_sshfs_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
