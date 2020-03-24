# Installs packages which must be locally built and installed due to
# licensing restrictions.
# Notes: xbps-src cannot be run as root

# Clone down packages repository
{{ pillar.manual_void_pkgs.clone_dir }}:
  file.directory:
    - user: noah
    - group: noah
    - makedirs: True

{{ pillar.manual_void_pkgs.clone_url }}:
  git.latest:
    - target: {{ pillar.manual_void_pkgs.clone_dir }}
    - user: noah
    - require:
      - file: {{ pillar.manual_void_pkgs.clone_dir }}

# Configure package builder
{{ pillar.manual_void_pkgs.config_file }}:
  file.managed:
    - user: noah
    - group: noah
    - source: salt://manual-void-pkgs/conf
    - require:
      - git: {{ pillar.manual_void_pkgs.clone_url }}

# Install build dependencies
binary_bootstrap:
  cmd.run:
    - name: ./xbps-src binary-bootstrap
    - runas: noah
    - cwd: {{ pillar.manual_void_pkgs.clone_dir }}
    - require:
      - file: {{ pillar.manual_void_pkgs.config_file }}        

# Install packages
{% for pkg, details in pillar['manual_void_pkgs']['pkgs'].items() %}
pkg_{{ pkg }}:
  cmd.run:
    - name: ./xbps-src pkg {{ pkg }}
    - runas: noah
    - cwd: {{ pillar.manual_void_pkgs.clone_dir }}
    - require:
      - cmd: binary_bootstrap

install_{{ pkg }}:
  cmd.run:
    - name: xbps-install --repository={{ pillar.manual_void_pkgs.clone_dir }}/hostdir/binpkgs/{{ details.repository }} -y zoom
    - cwd: {{ pillar.manual_void_pkgs.clone_dir }}
    - require:
      - cmd: pkg_{{ pkg }}
{% endfor %}
