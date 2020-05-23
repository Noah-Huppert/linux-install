# Install Minecraft
{{ pillar.minecraft.archive_file }}:
  file.managed:
    - source: {{ pillar.minecraft.archive_url }}
    - source_hash: {{ pillar.minecraft.archive_256sum }}
    - makedirs: True

{{ pillar.minecraft.install_dir }}:
  archive.extracted:
    - source: {{ pillar.minecraft.archive_file }}
    - user: noah
    - group: noah
    - require:
      - file: {{ pillar.minecraft.archive_file }}

{{ pillar.minecraft.launcher_script }}:
  file.managed:
    - source: salt://minecraft/launcher.sh
    - template: jinja
    - mode: 555

# Download mods
{% for mod in pillar['minecraft']['mods'] %}
{{ pillar.minecraft.mods_dir }}/{{ mod.dest }}:
  file.managed:
    - source: {{ mod.source_url }}
    - source_hash: {{ mod.source_256sum }}
    - makedirs: True
    - mode: 555
{% endfor %}
