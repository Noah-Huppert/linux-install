{{ pillar.pirate_get.pkg }}:
  pip.installed:
    - pip_bin: {{ pillar.python.pip3_bin }}
