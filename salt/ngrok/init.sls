# Install Ngrok
download_ngrok:
  archive.extracted:
    - name: {{ pillar.ngrok.download_dir }}
    - source: {{ pillar.ngrok.download_url }}
    - source_hash: {{ pillar.ngrok.download_sha256sum }}
    - enforce_toplevel: False
