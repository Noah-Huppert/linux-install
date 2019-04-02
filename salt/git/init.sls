# Install and configure Git.

# Package
git:
  pkg.installed

# User configuration
/home/noah/.gitconfig:
  file.managed:
    - source: salt://git/configuration/noah
    - template: jinja
    - user: noah
    - group: noah
    - mode: 644
