# Configures the Salt minion to find Salt states in:
#
#   - /srv/salt
#   - /srv/salt-secrets
#
# And pillars in:
#
#   - /srv/pillar
#   - /srv/pillar-secrets
#

/etc/salt/minion:
  file.managed:
    - source: salt://salt-config/minion
    - mode: 664
