# Installs scripts repository

# Download
{{ pillar.scripts_repo.repository }}:
  git.cloned:
    - target: {{ pillar.scripts_repo.directory }}
    - user: noah

{{ pillar.scripts_repo.private_repository }}:
  git.cloned:
    - target: {{ pillar.scripts_repo.private_directory }}
    - user: noah      
