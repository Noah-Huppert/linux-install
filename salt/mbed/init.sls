# Installs ARM MBed CLI

{{ pillar.mbed.pip_pkg }}:
  pip.installed:
    - pip_bin: {{ pillar.python.pip2_bin }}
