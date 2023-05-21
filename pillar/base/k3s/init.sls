k3s:
  # Packages required to install k3s
  pkgs: []

  # Service file
  svc:
    # Relative to k3s salt dir
    source: ""
    install: ""

  # Directory in which K8s manifests can be saved and which k3s will auto-deploy
  auto_deploy_manifests_dir: /var/lib/rancher/k3s/server/manifests
  remote_manifests:
    - file: k8s-dashboard.yaml
      url: https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
      sha: 943ae40251f1ba64ef012c53271bf6766d1883dd024093e854567b56443764b8

  # Configuration file
  config_file: /etc/rancher/k3s/config.yaml
