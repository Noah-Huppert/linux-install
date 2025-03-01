# Installs the Chirp radio configuration utility (https://chirpmyradio.com/projects/chirp/wiki/Home)
chirp_multipkg:
  multipkg.installed:
    - pkgs: {{ pillar.chirp.multipkg }}
