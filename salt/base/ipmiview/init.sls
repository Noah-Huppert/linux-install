# Installs IPMI View, a Supermicro IPMI client (https://www.supermicro.com/en/solutions/management-software/bmc-resources)
ipmiview_multipkgs:
  multipkg.installed:
    - pkgs: {{ pillar.ipmiview.multipkgs }}
