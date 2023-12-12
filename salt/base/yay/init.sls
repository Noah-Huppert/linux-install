# Installs Pacman AUR manager yay

yay_aux_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.yay.aux_pkgs }}

yay_archive:
  archive.extracted:
    - name: {{ pillar.yay.download.dir }}
    - source: {{ pillar.yay.download.url }}
    - source_hash: {{ pillar.yay.download.sha }}

{{ pillar.yay.link.target }}:
  file.symlink:
    - target: {{ pillar.yay.link.source }}
