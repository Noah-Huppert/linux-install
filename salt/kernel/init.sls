# Install Linux kernel

{{ pillar.kernel.pkg }}-{{ pillar.kernel.version }}:
  pkg.installed
