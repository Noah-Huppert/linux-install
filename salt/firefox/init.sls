# Install Firefox

{{ pillar.firefox.pkg }}:
  pkg.installed

{{ pillar.firefox.mp4_codec_pkg }}:
  pkg.installed