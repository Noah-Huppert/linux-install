# User Instructions
Linux installation instructions for end users.

# Table Of Contents
- [Setup](#setup)

# Setup
Install the setup instructions for your particular Linux distribution.

## Setup Encrypted Partition
Run:

```
# /etc/linux-install/live-scripts/crypsetup.sh -p ROOT_PARTITION -c cryptroot
```

## Download Linux Install Repository
> Warning: It seems Salt doesn't work with Python 3.12.7, but is verified to work with Python 3.11
> 
> Using [uv](https://docs.astral.sh/uv/):
> ```shell
> curl -LsSf https://astral.sh/uv/0.4.6/install.sh | sh
> uv python install 3.11
> uv venv --python 3.11
> uv pip install salt
> ```

1. Clone this repository to the `/etc/linux-install/` directory
2. Run the `live-scripts/link-salt-dirs.sh` to make symlinks to the `/srv/{salt,pillar}` directory
3. Copy `salt/base/salt-configuration/minion` to `/etc/salt/minion/` and manually substitute the Jinja syntax
4. Run the `setup-scripts/make-salt-venv.sh` script to install Salt
5. Run `salt-call --local state.apply salt-configuration`

## Manual Hacks
Some user guide information about manual settings which might need to be changed can be found in [`USER-PROGRAMS-HELP.md`][./USER-PROGRAMS-HELP.md].
