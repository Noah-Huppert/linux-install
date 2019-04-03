# Installs scripts repository

# Download
{{ pillar.scripts_repo.repository }}:
  git.latest:
    - target: {{ pillar.scripts_repo.directory }}
    - user: noah