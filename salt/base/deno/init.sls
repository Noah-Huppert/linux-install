# Installs deno from cargo.
# Install for all users
{% for _, user in pillar['users']['users'].items() %}
install_cargo_deno_for_{{ user.name }}:
  cmd.run:
    - name: {{ pillar.rust.cargo_bin_substitute_path }}/cargo install {{ pillar.deno.pkg }}
    - runas: {{ user.name }}
    - unless: test -f {{ pillar.rust.cargo_bin_substitute_path }}/deno
{% endfor %}
