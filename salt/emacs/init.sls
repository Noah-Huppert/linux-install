# Install and configure Emacs.

# Install
{{ pillar.emacs.pkg }}:
  pkg.installed

# Configuration file
{{ pillar.emacs.configuration_file }}:
  file.managed:
    - source: salt://emacs/init.el
    - user: noah
    - group: noah
    - mode: 644
