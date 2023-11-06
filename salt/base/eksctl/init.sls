# Installs eksctl

eksctl_extracted:
  archive.extracted:
    - name: {{ pillar.eksctl.install_path }}
    - source: {{ pillar.eksctl.download.url }}
    - source_hash: {{ pillar.eksctl.download.sha }}
    - enforce_toplevel: False
