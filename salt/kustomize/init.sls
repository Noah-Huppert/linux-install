# Install Kustomize

{{ pillar.kustomize.install_dir }}:
  archive.extracted:
    - source: {{ pillar.kustomize.download_url }}
    - source_hash: {{ pillar.kustomize.download_hash }}
    - enforce_toplevel: False
