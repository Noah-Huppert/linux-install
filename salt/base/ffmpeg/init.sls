# Installs ffmpeg from xbps.
# src=SRC
{% for pkg in pillar['ffmpeg']['xbps_ffmpeg_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
