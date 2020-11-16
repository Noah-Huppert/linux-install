# Install Zsh

{{ pillar.zsh.pkg }}:
  pkg.latest

{% for _, user in pillar['users']['users'].items() %}
{{ user.home }}/.zshrc:
  file.managed:
    - source: salt://zsh/zshrc
    - mode: 600
{% endfor %}
