{% set dir = '/home/noah/libs/android-sdk' %}
android_sdk:
  dir: {{ dir }}

  # SDK tools files
  cli_tools_zip: {{ dir }}/sdk-tools.zip
  cli_tools_url: https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
  cli_tools_hash: 92ffee5a1d98d856634e8b71132e8a95d96c83a63fde1099be3d86df3106def9

  # Users in group can access Android devices
  udev_group: androiddev

  # udev rules rule so devices can be discovered
  udev_rules_file: /etc/udev/rules.d/51-android.rules
  
  # SDK packages
  sdk_pkgs:
    - build-tools;29.0.1
    - build-tools;28.0.3
    - platform-tools
    - platforms;android-29
    - platforms;android-28
