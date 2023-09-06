# Installs Insomnia HTTP client
insomnia_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.insomnia.pkgs }}