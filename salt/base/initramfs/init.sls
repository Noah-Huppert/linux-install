# Configures Dracut to create an initial ram file system which supports booting
# from a LUKS container.

# Install build dependencies
{% for pkg in pillar['initramfs']['build_pkgs'] %}
{{ pkg }}:
  pkg.latest
{% endfor %}

# Dracut configuration
{{ pillar.initramfs.dracut_config_dir }}:
  file.recurse:
    - source: salt://initramfs/dracut.conf.d
    - dir_mode: 755
    - file_mode: 755

rebuild_cmd:
  cmd.run:
    - name: xbps-reconfigure -f {{ pillar.kernel.kernel_pkg }}
    - onchanges:
      - file: {{ pillar.initramfs.dracut_config_dir }}
    - require:
      {%- for pkg in pillar['initramfs']['build_pkgs'] %}
      - pkg: {{ pkg }}
      {% endfor %}
