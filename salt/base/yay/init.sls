# Installs Pacman AUR manager yay

yay_archive:
  archive.extracted:
    - name: {{ pillar.yay.download.dir }}
    - source: {{ pillar.yay.download.url }}
    - source_hash: {{ pillar.yay.download.sha }}

{{ pillar.yay.link.target }}:
  file.symlink:
    - target: {{ pillar.yay.link.source }}

{{ pillar.salt_configuration.custom_modules_dir }}/{{ pillar.yay.salt_module_dir }}:
  file.recurse:
    - source: salt://yay/aurpkg
