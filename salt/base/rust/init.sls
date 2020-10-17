# Installs the Rust language.

{{ pillar.rust.rustup.pkg }}:
  pkg.installed
  
{% for _, user in pillar['users']['users'].items() %}
rustup_for_{{ user.name }}:
  cmd.run:
    - name: {{ pillar.rust.rustup.init_cmd }}
    - runas: {{ user.name }}
    - unless: test -f {{ pillar.rust.cargo_bin_substitute_path }}/rustc
    - require:
      - pkg: {{ pillar.rust.rustup.pkg }}
{% endfor %}
