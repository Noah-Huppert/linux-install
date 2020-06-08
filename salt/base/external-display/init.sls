# Configure hooks for the xtend script
# (Found in the github.com/Noah-Huppert/scripts repository)

{{ pillar.external_display.on_hook_file }}:
  file.managed:
    - source: salt://external-display/on
    - template: jinja
    - makedirs: True
    - user: noah
    - group: noah
    - mode: 755

{{ pillar.external_display.off_hook_file }}:
  file.managed:
    - source: salt://external-display/off
    - template: jinja
    - makedirs: True
    - user: noah
    - group: noah
    - mode: 755
