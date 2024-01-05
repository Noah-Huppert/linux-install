# Installs qBittorrent
qbittorrent_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.qbittorrent.pkgs }}
