# Installs the denon Deno tool.
{{ pillar.denon.file }}:
  file.managed:
    - source: salt://denon/denon
    - template: jinja
    - mode: 755
