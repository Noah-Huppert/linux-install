{{ pillar.omnisharp.install_dir }}:
  archive.extracted:
    - source: {{ pillar.omnisharp.download.url }}
    - source_hash: {{ pillar.omnisharp.download.sha256sum }}

{{ pillar.omnisharp.run_file.create }}:
  file.managed:
    - source: salt://omnisharp/omnisharp
    - template: jinja
    - mode: 775
