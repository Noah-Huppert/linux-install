# Installs Jq
jq_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.jq.pkgs }}
