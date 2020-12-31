# Installs denopack tool shortcut.
{% for _, user in pillar['users']['users'].items() %}
install_denopack_{{ user.name }}:
  cmd.run:
    - name: {{ pillar.rust.cargo_bin_substitute_path }}/deno run --allow-net --allow-run --allow-read {{ pillar.denopack.url }}
    - runas: {{ user.name }}
    - unless: test -f $HOME/{{ pillar.deno.user_bin_dir }}/{{ pillar.denopack.bin }}
{% endfor %}
