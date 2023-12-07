{% set sdk_root = '/home/noah/.local/lib/android-sdk' %}
{% set cli_tools_extract_parent_dir = sdk_root + '/download' %}
{% set cli_tools_extract_target_dir = cli_tools_extract_parent_dir + '/cmdline-tools' %}
{% set cli_tools_dir = sdk_root + '/cmdline-tools/latest' %}
android_sdk:
  sdk_root: {{ sdk_root }}

  # SDK tools files
  cli_tools_extract_parent_dir: {{ cli_tools_extract_parent_dir }}
  cli_tools_extract_target_dir: {{ cli_tools_extract_target_dir }}
  cli_tools_dir: {{ cli_tools_dir }}

  # https://developer.android.com/studio
  cli_tools_url: https://dl.google.com/android/repository/commandlinetools-linux-10406996_latest.zip
  cli_tools_hash: 8919e8752979db73d8321e9babe2caedcc393750817c1a5f56c128ec442fb540

  # Users in group can access Android devices
  udev_group: androiddev

  # udev rules rule so devices can be discovered
  udev_rules_file: /etc/udev/rules.d/51-android.rules
  
  # SDK packages
  sdk_pkgs:
    - build-tools;34.0.0
    - platform-tools
    - platforms;android-34
