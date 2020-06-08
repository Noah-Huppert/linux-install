# Install and configure the finger print reader

# Install
{{ pillar.fingerprint_reader.pkg }}:
  pkg.installed

# Configure PAM to use fingerprint
{{ pillar.fingerprint_reader.pam_configuration_file }}:
  file.managed:
    - source: salt://fingerprint-reader/pam.d/system-local-login
    - mode: 644
