# Install Linux kernel

{{ pillar.kernel.pkg }}:
  pkg.installed:
    - version: {{ pillar.kernel.version }}
