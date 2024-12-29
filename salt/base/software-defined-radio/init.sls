# Install GNU Radio

software_defined_radio_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.software_defined_radio.pkgs }}

{{ pillar.software_defined_radio.gnu_radio_companion_conf }}:
  file.managed:
    - source: salt://software-defined-radio/grc.conf
    - require:
      - pkg: software_defined_radio_pkgs
