# Installs Cockatrice (https://cockatrice.github.io/)
cockatrice_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.cockatrice.pkgs }}
