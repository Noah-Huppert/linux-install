aws_cli:
  # AWS CLI PIP packages
  pip_pkgs:
    - awscli
    - boto3

  # XBPS dependency packages
  xbps_dep_pkgs:
    # GNU text formatter
    - groff

  # Credentials configuration file
  credentials_file: /home/noah/.aws/credentials
