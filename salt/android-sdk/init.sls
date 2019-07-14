# Installs android SDK
# Download sdk tools
{{ pillar.android_sdk.cli_tools_zip }}:
  file.managed:
    - source: {{ pillar.android_sdk.cli_tools_url }}
    - source_hash: {{ pillar.android_sdk.cli_tools_hash }}
    - makedirs: True
    - user: noah
    - group: noah

{{ pillar.android_sdk.dir }}:
  archive.extracted:
    - source: {{ pillar.android_sdk.cli_tools_zip }}
    - user: noah
    - group: noah
    - require:
      - file: {{ pillar.android_sdk.cli_tools_zip }}

# Accept licenses
accept_licenses:
  cmd.run:
    - name: yes | {{ pillar.android_sdk.dir }}/tools/bin/sdkmanager --licenses
    - require:
      - archive: {{ pillar.android_sdk.dir }}

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
{{ pillar.android_sdk.dir }}/tools/bin/sdkmanager '{{ pkg }}':
  cmd.run:
    - require:
      - cmd: accept_licenses
{% endfor %}

