# Install and configure Weechat.

# Configuration directory
{{ pillar.weechat.configuration_repo }}:
  git.cloned:
    - target: {{ pillar.weechat.configuration_directory }}
    - user: noah

# Install
{% for pkg in pillar['weechat']['pkgs'] %}
{{ pkg }}:
  pkg.latest:
    - require:
      - git: {{ pillar.weechat.configuration_repo }}
{% endfor %}
