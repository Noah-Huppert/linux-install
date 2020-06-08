# Installs the Rust language.

{{ pillar.rust.rustup.pkg }}:
  pkg.installed

{{ pillar.rust.rustup.init_cmd }}:
  cmd.run:
    - runas: noah
    - unless: test -f {{ pillar.rust.cargo_bin_substitute_path }}/rustc
    - require:
      - pkg: {{ pillar.rust.rustup.pkg }}
