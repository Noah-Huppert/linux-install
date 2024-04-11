# Httpie is a HTTP CLI client
httpie_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.httpie.pkgs }}
