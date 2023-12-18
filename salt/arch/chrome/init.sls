# Installs Google Chrome from AUR
chrome_aur_pkgs:
  aurpkg.installed:
    - pkgs: {{ pillar.chrome.aur_pkgs }}

{% for _, user in pillar['users']['users'].items() %}
{{ user.home }}/{{ pillar.chrome.user_config_file }}:
  file.managed:
    - user: {{ user.name }}
    - group: {{ user.name }}
    - source: salt://chrome/chromium-flags.conf
{% endfor %}
