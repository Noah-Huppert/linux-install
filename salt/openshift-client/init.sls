# Install OpenShift 4 client

{{ pillar.openshift_client.install_dir }}:
  archive.extracted:
    - source: salt://openshift-client/oc.tar.gz
    - mode: 755
    - enforce_toplevel: False
