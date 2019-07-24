# Installs net-tools packages, includes binaries like netstat
{{ pillar.net_tools.pkg }}:
  pkg.latest
