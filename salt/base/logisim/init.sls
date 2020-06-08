# Installs Logisim
{{ pillar.logisim.jar_file }}:
  file.managed:
    - source: {{ pillar.logisim.jar_url }}
    - source_hash: {{ pillar.logisim.jar_hash }}
    - makedirs: True
    - dir_mode: 755
    - mode: 755

{{ pillar.logisim.run_script }}:
  file.managed:
    - source: salt://logisim/run-script.sh
    - mode: 755
    - template: jinja
  
