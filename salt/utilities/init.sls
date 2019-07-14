# Install misc. utilities.

# XBPS
{% for pkg in pillar['utilities']['xbps_pkgs'] %}
{{ pkg }}:
  pkg.latest
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
{% for pkg in pillar['utilities']['go_pkgs'] %}
go get -u {{ pkg }}:
  cmd.run:
    - unless: test -d "$GOPATH/src/{{ pkg }}"
{% endfor %}
