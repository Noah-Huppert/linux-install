# Installs Kubectx (https://github.com/ahmetb/kubectx)
kubectx_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.kubectx.pkgs }}
