# Install and configure Emacs.

# Configuration directory
{{ pillar.emacs.configuration_repo }}:
  git.cloned:
    - target: {{ pillar.emacs.configuration_directory }}
    - user: noah

# Install
{{ pillar.emacs.pkg }}:
  pkg.installed:
    - required:
      - git: {{ pillar.emacs.configuration_repo }}