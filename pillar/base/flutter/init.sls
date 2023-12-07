{% set parent_dir = '.local/share' %}
{% set dir = parent_dir + '/flutter' %}
flutter:
  # Working directory
  parent_dir: {{ parent_dir }}
  dir: {{ dir }}
  
  # Download URL
  download_url: https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.16.3-stable.tar.xz

  # Download file sha256
  download_sha: 22196f6e5d8b67cbdddf1fc94f62da07addb67da0210d0498cbcff6ddcb7127e

  # Download file
  download_file: {{ dir }}/flutter.tar.gz

  # Extract directory
  extract_dir: {{ dir }}

  # Install location
  install_dir: .local/bin
  install_targets_dir: {{ dir }}/bin
  install_targets:
    - flutter
    - dart

  # Dependency packages
  dep_pkgs: []
