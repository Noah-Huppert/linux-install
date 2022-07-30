{{ pillar.omnisharp.install_dir }}:
  archive.extracted:
    - source: {{ pillar.omnisharp.download.url }}
    - source_hash: {{ pillar.omnisharp.download.sha256sum }}

{{ pillar.omnisharp.symlink.create }}:
  file.symlink:
    - target: {{ pillar.omnisharp.symlink.target }}
    - require:
        - archive: {{ pillar.omnisharp.install_dir }}
