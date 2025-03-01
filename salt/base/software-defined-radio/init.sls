# Install GNU Radio

software_defined_radio_pkgs:
  multipkg.installed:
    - pkgs: {{ pillar.software_defined_radio.multipkgs }}

{{ pillar.software_defined_radio.gnu_radio_companion_conf }}:
  file.managed:
    - source: salt://software-defined-radio/grc.conf
    - require:
      - multipkg: software_defined_radio_pkgs
