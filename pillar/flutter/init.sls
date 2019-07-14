{% set dir = '/home/noah/install/flutter' %}
flutter:
  # Working directory
  dir: {{ dir }}
  
  # Download URL
  download_url: https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v1.5.4-hotfix.2-stable.tar.xz

  # Download file sha256
  download_sha: 04e063b01e7087eeeccfc5f7a585ed6adcc521bc44f754e194cb3c98a57c19cd

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
