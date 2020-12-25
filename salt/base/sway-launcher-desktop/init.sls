# Installs sway launcher desktop.

# Install dependencies
{% for pkg in pillar['sway_launcher_desktop']['dep_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}

# Download script
{{ pillar.sway_launcher_desktop.dir }}:
  archive.extracted:
    - source: {{ pillar.sway_launcher_desktop.repo_zip }}
    - source_hash: {{ pillar.sway_launcher_desktop.repo_zip_hash }}
