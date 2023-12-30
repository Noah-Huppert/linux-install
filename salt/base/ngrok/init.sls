# Install Ngrok
ngrok_pkgs:
  {{ pillar.ngrok.pkgs_state }}.installed:
    - pkgs: {{ pillar.ngrok.pkgs }}
