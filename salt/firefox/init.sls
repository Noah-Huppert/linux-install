# Install Firefox

{{ pillar.firefox.pkg }}:
  pkg.latest

{{ pillar.firefox.mp4_codec_pkg }}:
  pkg.latest
