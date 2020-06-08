# Configure touchpad to accept taps and perform palm rejection.

{{ pillar.touchpad.configuration_file }}:
  file.managed:
    - source: salt://touchpad/99-synaptics-overrides.conf
    - makedirs: True