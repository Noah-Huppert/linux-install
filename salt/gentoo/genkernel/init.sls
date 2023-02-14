# Configure the genkernel tool
{{ pillar.genkernel.conf_file }}:
  file.managed:
    - source: salt://genkernel/genkernel.conf