# Install and configure Weechat.

# Configuration directory
{{ pillar.weechat.configuration_repo }}:
  git.cloned:
    - target: {{ pillar.weechat.configuration_directory }}
    - user: noah

# Install
{{ pillar.weechat.pkg }}:
  pkg.installed:
    - require:
      - git: {{ pillar.weechat.configuration_repo }}