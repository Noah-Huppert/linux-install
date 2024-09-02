# Installs the icedtea program to open .jnlp files which encode remote connection information for taking over bare metal servers
icedtea_web_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.icedtea_web.pkgs }}
