{% set dir = '/home/noah/install/flutter' %}
flutter:
  # Working directory
  dir: {{ dir }}
  
  # Download URL
  download_url: https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_2.2.3-stable.tar.xz

  # Download file sha256
  download_sha: 66a271aa9f4286596841f5c89fd5d22e4ae0042127459e88d5650ca989ba948d

  # Download file
  download_file: {{ dir }}/flutter.tar.gz

  # Extract directory
  extract_dir: {{ dir }}/flutter

  # Install location
  install_file: /home/noah/bin/flutter
  install_target: {{ dir }}/flutter/bin/flutter

  # Dependency packages
  dep_pkgs:
    - libstdc++
    - libstdc++-32bit
