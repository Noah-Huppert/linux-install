# Install and configure Emacs.

# Configuration directory
{{ pillar.emacs.configuration_repo }}:
  git.cloned:
    - target: {{ pillar.emacs.configuration_directory }}
    - user: noah

# Install
{% for pkg in pillar['emacs']['pkgs'] %}
{{ pkg }}:
  pkg.latest:
    - required:
      - git: {{ pillar.emacs.configuration_repo }}
{% endfor %}
