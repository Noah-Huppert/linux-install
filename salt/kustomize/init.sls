# Install Kustomize

download_kustomize:
  archive.extracted:
    - name: {{ pillar.kustomize.install_dir }}
    - source: {{ pillar.kustomize.download_url }}
    - source_hash: {{ pillar.kustomize.download_hash }}
    - enforce_toplevel: False
