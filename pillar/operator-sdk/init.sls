operator_sdk:
  download_url: 'https://github.com/operator-framework/operator-sdk/releases/download/v0.8.2/operator-sdk-v0.8.2-x86_64-linux-gnu'

  # A GPG signature file was provided with download_url
  # https://github.com/operator-framework/operator-sdk/releases/download/v0.8.2/operator-sdk-v0.8.2-x86_64-linux-gnu.asc
  # I manually verified this with GPG
  # gpg2 --verify operator-sdk-v0.8.2-x86_64-linux-gnu operator-sdk-v0.8.2-x86_64-linux-gnu.asc
  # And then got the sha256sum
  download_sha: ac2a0b45679452a0e7de7736bc1dba7123ec7105fbd7ababd6682a8d0c6a35a5

  install_file: /usr/local/bin/operator-sdk
