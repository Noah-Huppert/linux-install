# Installs Rsync
rsync_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.rsync.pkgs }}
