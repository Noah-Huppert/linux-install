# Installs Buffalo (https://gobuffalo.io) Go web framework CLI

{{ pillar.buffalo.install_dir }}:
  archive.extracted:
    - source: {{ pillar.buffalo.download.url }}
    - source_hash: {{ pillar.buffalo.download.sha256 }}
    - enforce_toplevel: False

{{ pillar.buffalo.link.destination }}:
  file.symlink:
    - target: {{ pillar.buffalo.link.source }}
    - mode: 755
    - require:
      - archive: {{ pillar.buffalo.install_dir }}
