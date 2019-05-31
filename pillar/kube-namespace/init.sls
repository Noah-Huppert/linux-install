{% set dir = '/opt/kube-namespace' %}

kube_namespace:
  # Repository URL
  repo_url: https://github.com/Noah-Huppert/kube-namespace.git

  # Install directory
  install_dir: {{ dir }}

  # File with kubens function
  install_file: {{ dir }}/kubens
