# Install misc. utilities.

# XBPS
{% for pkg in pillar['utilities']['xbps_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}

# Python 3
{% for pkg in pillar['utilities']['python3_pkgs'] %}
{{ pkg }}:
  pip.installed:
    - pip_bin: {{ pillar.python.pip3_bin }}
{% endfor %}

# NodeJS 
{% for pkg in pillar['utilities']['node_pkgs'] %}
'{{ pkg }}':
  npm.installed
{% endfor %}

# Git repositories
{% for _, user in pillar['users']['users'].items() %}
{% for repo in pillar['utilities']['git_repos'] %}
git_latest_{{ repo.repo }}_for_{{ user.name }}:
  git.latest:
    - name: {{ repo.repo }}
    - target: {{ user.home }}/bin/{{ repo.dir }}
{% endfor %}

# Go packages
{% for bin in pillar['utilities']['go_pkgs'] %}
go_get_{{ bin }}_for_{{ user.name }}:
  cmd.run:
    - name: go get {{ pillar['utilities']['go_pkgs'][bin] }}
    - runas: {{ user.name }}
    - unless: test -f "{{ pillar.go.go_substitute_path }}/bin/{{ bin }}"
      
go_install_{{ bin }}_for_{{ user.name }}:
  cmd.run:
    - name: go install {{ pillar['utilities']['go_pkgs'][bin] }}
    - runas: {{ user.name }}
    - unless: test -f "{{ pillar.go.go_substitute_path }}/bin/{{ bin }}"      
{% endfor %}

# Rust packages
{% for bin in pillar['utilities']['rust_pkgs'] %}
cargo_install_{{ bin }}_for_{{ user.name }}:
  cmd.run:
    - name: {{ pillar.rust.cargo_bin_substitute_path }}/cargo install {{ pillar['utilities']['rust_pkgs'][bin] }}
    - runas: {{ user.name }}
    - unless: test -f {{ pillar.rust.cargo_bin_substitute_path }}/{{ bin }}
{% endfor %}
{% endfor %}
