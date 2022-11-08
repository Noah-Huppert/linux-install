{{ pillar.omnisharp.install_dir }}:
  archive.extracted:
    - source: {{ pillar.omnisharp.download.url }}
    - source_hash: {{ pillar.omnisharp.download.sha256sum }}

{{ pillar.omnisharp.link.destination }}:
  file.symlink:
    - target: {{ pillar.omnisharp.link.source }}
    - depends_on:
      - file: {{ pillar.omnisharp.install_dir }}