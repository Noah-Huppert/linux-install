# Install and configure flatpak

# Install
{% for pkg in pillar['flatpak']['pkgs'] %}
{{ pkg }}:
  pkg.latest
{% endfor %}

# Configure
flatpak remote-add --if-not-exists flathub {{ pillar.flatpak.repository }}:
  cmd.run:
    - unless: bash -c '[ -z "$(flatpak remote-ls)" ] && exit 1; exit 0'
    - require:
      {% for pkg in pillar['flatpak']['pkgs'] %}
      - pkg: {{ pkg }}
      {% endfor %}
