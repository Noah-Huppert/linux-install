# Install GNU Radio

{% for pkg in pillar['software_defined_radio']['pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}


{{ pillar.software_defined_radio.gnu_radio_companion_conf }}:
  file.managed:
    source: salt://software-defined-radio/grc.conf
