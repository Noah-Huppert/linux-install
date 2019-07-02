{% set dir = '/opt/flutter-sdk' %}
flutter:
  # Group
  group: flutter
  
  # Working directory
  dir: {{ dir }}
  
  # Download URL
  download_url: https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v1.5.4-hotfix.2-stable.tar.xz

  # Download file
  download_file: {{ dir }}/flutter.tar.gz

  # Install location
  install_file: /usr/bin/flutter
  install_target: {{ dir }}/flutter/bin/flutter
