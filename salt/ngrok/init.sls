# Install Ngrok
{{ pillar.ngrok.download_dir }}:
  archive.extracted:
    - source: {{ pillar.ngrok.download_url }}
    - source_hash: {{ pillar.ngrok.download_sha256sum }}
    - enforce_toplevel: False
