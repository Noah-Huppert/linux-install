# Installs the Velociraptor run tool.
{% for _, user in pillar['users']['users'].items() %}
install_velociraptor_{{ user.name }}:
  cmd.run:
    - name: {{ pillar.rust.cargo_bin_substitute_path }}/deno install -A -n {{ pillar.velociraptor.bin }} {{ pillar.velociraptor.url }}
    - runas: {{ user.name }}
    - unless: test -f $HOME/{{ pillar.deno.user_bin_dir }}/{{ pillar.velociraptor.bin }}
{% endfor %}
