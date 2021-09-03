{% set script_dir = '/opt/gpg-import' %}
gpg:
  pkgs:
    - gnupg2
    - pinentry-qt
  
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
