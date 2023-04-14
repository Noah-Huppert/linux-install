{% set script_dir = '/opt/gpg-import' %}
gpg:
  # User GPG agent configuration options
  # Value of null means its a simple flag option and just the key will appear in the config file
  agent_config_opts: {}
  
  # Packages to install for GPG
  pkgs: []
  
  # Names of GPG import files
  import_files:
    public: pub.asc
    private: priv.asc
    trust: trust.asc

  # Keys of users. Dict key values are usernames, values are key IDs
  user_keys:
      noah: 0F3195D1242550D23B602E45FDE646A64CA10626

  # GPG configuration directory in user home
  gpg_home_dir: .gnupg
  agent_config: gpg-agent.conf
