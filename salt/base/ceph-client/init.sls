# Installs Ceph CLI client
install_ceph_client:
  pkg.installed:
    - pkgs: {{ pillar.ceph_client.pkgs }}