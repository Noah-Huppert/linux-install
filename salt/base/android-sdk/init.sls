# Installs android SDK
# Download sdk tools and then copy them into the right directory
{{ pillar.android_sdk.cli_tools_extract_parent_dir }}:
  archive.extracted:
    - source: {{ pillar.android_sdk.cli_tools_url }}
    - source_hash: {{ pillar.android_sdk.cli_tools_hash }}
    - user: noah
    - group: noah

{{ pillar.android_sdk.cli_tools_dir }}:
  file.copy:
    - source: {{ pillar.android_sdk.cli_tools_extract_target_dir }}
    - makedirs: True
    - require:
      - archive: {{ pillar.android_sdk.cli_tools_extract_parent_dir }}

# Accept licenses
accept_licenses:
  cmd.run:
    - name: yes | {{ pillar.android_sdk.cli_tools_dir }}/bin/sdkmanager --licenses
    - require:
      - file: {{ pillar.android_sdk.cli_tools_dir }}

# Create udev group
{{ pillar.android_sdk.udev_group }}:
  group.present:
    - members:
      - noah

# udev rules file
{{ pillar.android_sdk.udev_rules_file }}:
  file.managed:
    - source: salt://android-sdk/udev.rules
    - template: jinja
    
# Install SDK packages
{% for pkg in pillar['android_sdk']['sdk_pkgs'] %}
{{ pillar.android_sdk.cli_tools_dir }}/bin/sdkmanager '{{ pkg }}':
  cmd.run:
    - require:
      - cmd: accept_licenses
{% endfor %}

