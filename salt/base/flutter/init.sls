# Install Flutter SDK

{% for user in pillar['users']['users'].values() %}
# Extract tar.gz        
{{ user.home }}/{{ pillar.flutter.parent_dir }}:
  archive.extracted:
    - source: {{ pillar.flutter.download_url }}
    - source_hash: {{ pillar.flutter.download_sha }}      
    - user: {{ user.name }}
    - group: {{ user.name }}

# Install
{% for install_target in pillar['flutter']['install_targets'] %}
{{ user.home }}/{{ pillar.flutter.install_dir }}/{{ install_target }}:
  file.symlink:
    - target: {{ user.home }}/{{ pillar.flutter.install_targets_dir }}/{{ install_target }}
    - makedirs: True
    - require:
      - archive: {{ user.home }}/{{ pillar.flutter.parent_dir }}
{% endfor %}
{% endfor %}

# Install dependencies
{% for pkg in pillar['flutter']['dep_pkgs'] %}
{{ pkg }}:
  pkg.latest
{% endfor %}
