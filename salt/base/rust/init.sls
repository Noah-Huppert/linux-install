# Installs the Rust language.

{{ pillar.rust.rustup.pkg }}:
  pkg.installed
  
{% for _, user in pillar['users']['users'].items() %}
rustup_for_{{ user.name }}:
  cmd.run:
    - name: {{ pillar.rust.rustup.init_cmd }}
    - runas: {{ user.name }}
    - unless: {{ pillar.rust.cargo_bin_substitute_path }}/rustc --version | grep {{ pillar.rust.version }}
    - require:
      - pkg: {{ pillar.rust.rustup.pkg }}

{% for rust_target in pillar['rust']['rustup']['targets'] %}
{% set nice_rust_target_name = rust_target | replace("-", "_") %}
rustup_target_{{ nice_rust_target_name }}_for {{ user.name }}:
  cmd.run:
    - name: {{ pillar.rust.cargo_bin_substitute_path }}/rustup target install {{ rust_target }}
    - runas: {{ user.name }}
    - unless: {{ pillar.rust.cargo_bin_substitute_path }}/rustup target list --installed | grep {{ rust_target }}
    - require:
      - cmd: rustup_for_{{ user.name }}
{% endfor %}
{% endfor %}
