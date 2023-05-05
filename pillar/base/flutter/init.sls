{% set parent_dir = '.local/share' %}
{% set dir = parent_dir + '/flutter' %}
flutter:
  # Working directory
  parent_dir: {{ parent_dir }}
  dir: {{ dir }}
  
  # Download URL
  download_url: https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.7.12-stable.tar.xz

  # Download file sha256
  download_sha: 898f7f34dcf19353060dfa33ef20e9d674c2c04dc8cc5ddae9d5ff16042dbc2e

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
