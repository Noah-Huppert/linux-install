{{ pillar.ngrok.install_file }}:
  file.managed:
    - source: {{ pillar.ngrok.download_url }}
    - source_hash: {{ pillar.ngrok.download_sha256sum }}
    - mode: 755
