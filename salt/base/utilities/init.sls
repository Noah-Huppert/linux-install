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
{% for repo in pillar['utilities']['git_repos'] %}
'{{ repo.repo }}':
  git.latest:
    - target: /home/noah/bin/{{ repo.dir }}
{% endfor %}  

# Go packages
{% for bin in pillar['utilities']['go_pkgs'] %}
go get {{ pillar['utilities']['go_pkgs'][bin] }}:
  cmd.run:
    - runas: {{ user.name }}
    - unless: test -f "{{ pillar.go.go_substitute_path }}/bin/{{ bin }}"
      
go install {{ pillar['utilities']['go_pkgs'][bin] }}:
  cmd.run:
    - runas: {{ user.name }}
    - unless: test -f "{{ pillar.go.go_substitute_path }}/bin/{{ bin }}"      
{% endfor %}

# Rust packages
{% for bin in pillar['utilities']['rust_pkgs'] %}
cargo install {{ pillar['utilities']['rust_pkgs'][bin] }}:
  cmd.run:
    - runas: noah
    - unless: test -f {{ pillar.rust.cargo_bin_substitute_path }}/{{ bin }}
{% endfor %}
