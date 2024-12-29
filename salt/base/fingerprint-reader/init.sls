# Install and configure the finger print reader

# Install
fingerprint_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.fingerprint_reader.pkgs }}

# Configure PAM to use fingerprint
{% for file in pillar['fingerprint_reader']['pam_configuration_files'] %}
/etc/pam.d/{{ file }}:
  file.managed:
    - source: salt://fingerprint-reader/pam.d/{{ file }}
    - mode: 644
{% endfor %}
