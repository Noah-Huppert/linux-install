# Installs YQ (JQ for YAML)
yq_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.yq.pkgs }}
