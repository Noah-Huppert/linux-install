# Developer Instructions
Documentation aimed at developers of this repository.

# Table Of Contents
- [Overview](#overview)
- [Directories](#directories)
- [Salt Environments](#salt-environments)

# Overview
This repository contains configuration as code which sets up my Linux 
environment. This configuration is for a tool named 
[Salt](https://www.saltstack.com/) which handles almost all aspects of system
configuration. With the exception of the very first boot where Salt
must be installed and the general environment must be bootstrapped.

Multiple computers of mine use the configuration in this repository. 
[Salt Environments](#salt-environments) are used to pick and customize what
pieces of configuration are setup on each system. 

# Directories
- **live-scripts**: Scripts for installing Void linux
- **setup-scripts**: Scripts for setting up the installation process
- **salt**: Salt states for Void installation
- **pillar**: Salt pillars for Void installation
- **screenshots**

# Salt Environments
Salt provides environments for the purpose of using the same configuration files
over multiple computers. This system recognizes that small details may need to 
be tweaked from environment to environment.

The `base` environment contains all the main configuration files. All other 
environments simply extend this `base` environment.

## Creating a Salt Environment
Salt environments are made up of the following:

- A folder with the name of the environment in the `salt` and 
  `pillar` directories
- Configuration for the Salt minions to recognize the new environment

Follow the instructions below:

1. Pick an environment name, any time you see `REPLACE_ME_ENV` in the 
   instructions below substitute the name with which you just came up.
2. Make the environment state and pillar directories:
   ```
   % mkdir -p {salt,pillar}/REPLACE_ME_ENV
   ```
3. Copy the pillar stack file:
   ```
   % cp pillar/base/pillar-stack.cfg pillar/REPLACE_ME_ENV
   ```
4. Create the `environment` pillar. First create a file to hold the 
   pillar's value:
   
   ```
   % echo "environment: REPLACE_ME_ENV" > pillar/REPLACE_ME_ENV/environment.sls
   ```
   
   Next create a top file which only includes this pillar named 
   `pillar/REPLACE_ME_ENV/top.sls` with the contents:
   
   ```
   REPLACE_ME_ENV:
     '*':
	   - environment
   ```
5. Add the environment to the `salt-configuration` pillar by editing the
   `pillar/base/salt-configuration/init.sls` file with the following:
   ```yaml
   salt_configuration:
     # ...
	 state_dirs:
	   # ...
	   REPLACE_ME_ENV:
	     public: {{ content_root }}/salt/REPLACE_ME_ENV
	 
	 # ...
	 pillar_dirs:
	   REPLACE_ME_ENV:
	     public: {{ content_root }}/pillar/REPLACE_ME_ENV
	 
	 # ...
	 pillar_stack:
	   # ...
	   REPLACE_ME_ENV:
	     public: {{ content_root }}/pillar/REPLACE_ME_ENV/pillar-stack.cfg
   ```
6. Add the environment to the Salt minion's configuration by editing
   the `salt/base/salt-configuration/minion` file with the following:
   ```yaml
   # ...
   file_roots:
     # ...
	 REPLACE_ME_ENV:
	   - {{ pillar.salt_configuration.state_dirs.REPLACE_ME_ENV.public }}
       - {{ pillar.salt_configuration.state_dirs.base.public }}
       - {{ pillar.salt_configuration.state_dirs.base.secret }}
	   
   # ...
   pillar_roots:
     # ...
	 REPLACE_ME_ENV:
	   - {{ pillar.salt_configuration.pillar_dirs.REPLACE_ME_ENV.public }}
	   
   # ...
   ext_pillar:
     - stack:
	     pillar:environment:
		   # ...
		   REPLACE_ME_ENV:
		     - {{ pillar.salt_configuration.pillar_stack.base.public }}
			 - {{ pillar.salt_configuration.pillar_stack.base.secret }}
			 - {{ pillar.salt_configuration.pillar_stack.REPLACE_ME_ENV.public }}
   ```
7. Add the environment to the `live-scripts/link-salt-dirs.sh` script by adding:
   ```bash
   # ...
   salt_state_links=(
       # ...
       "$repo_dir/salt/REPLACE_ME_ENV:$salt_content_dir/salt/REPLACE_ME_ENV
	   # ...
   )
   
   salt_pillar_links=(
       # ...
	   "$repo_dir/pillar/REPLACE_ME_ENV:$salt_content_dir/pillar/REPLACE_ME_ENV
	   # ...
   )
   ```
8. Create a Salt top file named `salt/REPLACE_ME_ENV/top.sls` with the content:
   ```
   REPLACE_ME_ENV:
     '*':
	   # Salt configuration
       - salt-configuration
     
	   - Now put a list of every salt state you want here
   ```
