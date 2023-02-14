# Install and configure Git.

# Package
{{ pillar.git.pkg }}:
  pkg.latest

# User configuration
/home/noah/.gitconfig:
  file.managed:
    - source: salt://git/noah.gitconfig
    - template: jinja
    - user: noah
    - group: noah
    - mode: 644
