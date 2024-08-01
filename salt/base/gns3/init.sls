# Installs the GNS3 network emulator
gns3_multipkg:
  multipkg.installed:
    - pkgs: {{ pillar.gns3.multipkgs }}
