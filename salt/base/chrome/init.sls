# Installs Chromium
chrome_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.chrome.pkgs }}
