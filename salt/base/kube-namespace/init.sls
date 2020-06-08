# Download kube namespace

{{ pillar.kube_namespace.repo_url }}:
  git.latest:
    - target: {{ pillar.kube_namespace.install_dir }}
