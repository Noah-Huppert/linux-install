# Configure system host name

{{ pillar.hostname.file }}:
  file.managed:
    - mode: 644
    - contents: {{ pillar.hostname.hostname }}
