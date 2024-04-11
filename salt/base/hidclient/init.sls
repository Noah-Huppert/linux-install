# Installs hidclient
hidclient_multipkg:
  multipkg.installed:
    - pkgs: {{ pillar.hidclient.multi_pkgs }}
