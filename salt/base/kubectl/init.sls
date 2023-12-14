# Installs kubectl
kubectl_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.kubectl.pkgs }}
